# Scaling the Mallow Billing Data Layer

This document explains how the schema is designed to hold **50M+ usage-event
rows** while keeping reads, aggregation, and invoicing fast, and the concrete
steps to take at each growth stage.

> Status: the schema is **normalized** and tuned for day-one correctness.
> The sections below describe the **progressive denormalization and
> partitioning** you should adopt as row counts climb past ~1M, ~10M, and
> ~50M+ rows.

---

## 1. Current schema at a glance

```
merchants ──┬── plans ─────────────────────────┐
            │                                  │
            ├── customers ──┬── usage_events   │
            │               │                  │
            │               └── subscriptions ─┼── subscription_segments ─► plan
            │                                  │
            │                                  └── invoices
            └── daily_usage (pre-aggregated)
```

| Table | Purpose | Growth characteristics |
|---|---|---|
| `usage_events` | Raw append-only metering rows | **Fast-growing**, one or more rows per customer per day |
| `daily_usage` | Denormalized `(customer, day) → units` | Grows `customers × days`, far smaller than raw events |
| `subscription_segments` | Plan history for a subscription | Low growth, but a few rows change per billing cycle |
| `invoices` | Final billed amounts | One row per subscription per cycle |

### Why `usage_events` is the bottleneck

At production volume a single day can add **hundreds of thousands** of rows:

```
5,000,000 events/month ÷ 30 days  ≈  166,000 events/day
25,000 active customers × 20 events/day  =  500,000 events/day   (heavier tenants)
```

Raw-event rows are rarely queried individually after they are ingested and
aggregated. The hot read and write paths are:

- **Write path:** `INSERT INTO usage_events ...` (high throughput, append-only).
- **Idempotency check:** `SELECT ... WHERE idempotency_key = ?`.
- **Aggregation (offline):** `SELECT customer_id, SUM(units) ... WHERE usage_date = ? GROUP BY customer_id`.
- **Invoicing (offline):** reads from `daily_usage`, not raw events.

> Rule of thumb: **never** run `SUM()` or dashboard queries directly against
> `usage_events` at scale. All reads go through `daily_usage`.

---

## 2. Indexing strategy (0 → 50M+ rows)

### Already in place

```sql
-- usage_events
UNIQUE KEY uq_idempotency_key (idempotency_key)          -- idempotent ingestion
INDEX     idx_customer_date   (customer_id, usage_date)  -- per-customer probes
INDEX     idx_date_customer   (usage_date, customer_id)  -- batch aggregation

-- daily_usage
UNIQUE KEY uq_customer_date   (customer_id, usage_date)  -- one row per customer/day

-- plans
INDEX     idx_merchant_cycle  (merchant_id, billing_cycle)

-- subscriptions
INDEX     idx_customer_status (customer_id, status)
INDEX     idx_plan_start      (plan_id, starts_at)

-- subscription_segments
INDEX     idx_segment_sub     (subscription_id, effective_from)
INDEX     idx_segment_plan    (plan_id, effective_from)

-- invoices
UNIQUE KEY uq_invoice_period  (subscription_id, period_start, period_end)
```

### What to add at 1M+ rows

1. **Compound index on the unique key order.** When `idempotency_key` is a
   `UNIQUE` index, lookups are already index-only. If you sometimes verify
   events by `(customer_id, idempotency_key)`, add:

   ```sql
   ALTER TABLE usage_events
     ADD INDEX idx_customer_key (customer_id, idempotency_key);
   ```

2. **Covering index for aggregation.** The aggregation query should be fully
   served from an index (no table fetch):

   ```sql
   ALTER TABLE usage_events
     ADD INDEX idx_date_customer_units (usage_date, customer_id, units);
   ```

   Now `GROUP BY customer_id, SUM(units)` filtered by `usage_date` reads the
   index alone. On MySQL `usage_date` (a `DATE`) is 3 bytes, so the index stays
   compact: ~22 bytes/row → under 2 GB of index for 50M rows.

3. **Partial indexes (PostgreSQL) / generated columns.** If a subset of
   tenants generates most traffic, a `WHERE` clause on `merchant_id` inside the
   index can collapse most reads. On MySQL use a generated `merchant_id`
   column; on PostgreSQL use a partial index:

   ```sql
   CREATE INDEX idx_usage_merchant_date
     ON usage_events (merchant_id, usage_date, customer_id, units)
     WHERE usage_date >= '2026-01-01';   -- PostgreSQL only
   ```

### When to stop indexing

Index write amplification is real. Once you introduce partitioning (below),
the partition key becomes the dominant query trimmer and several secondary
indexes become redundant — **measure with `EXPLAIN`** and drop any index that
the optimiser no longer uses. Only these three survive most partitioning
designs:

- `UNIQUE(idempotency_key)` — ingestion correctness.
- `INDEX(usage_date, customer_id, units)` — daily aggregation.
- `INDEX(customer_id, usage_date)` — customer-facing dashboards.

---

## 3. Partitioning strategy

Partitioning is the single highest-impact change for 5M–50M+ rows. **Do not
implement it until you have a retention + archival policy**, otherwise you are
only making deletes slower.

### 3.1 RANGE partitioning by `usage_date` (recommended for this schema)

```sql
ALTER TABLE usage_events
  PARTITION BY RANGE COLUMNS (usage_date) (
    PARTITION p2025_01 VALUES LESS THAN ('2025-02-01'),
    PARTITION p2025_02 VALUES LESS THAN ('2025-03-01'),
    PARTITION p2025_03 VALUES LESS THAN ('2025-04-01'),
    PARTITION p2026_01 VALUES LESS THAN ('2026-02-01'),
    -- ...one partition per month...
    PARTITION pfuture   VALUES LESS THAN (MAXVALUE)
  );
```

**Why monthly partitions**

- Aggregation is inherently daily/monthly → the partition is a perfect
  filter; MySQL prunes partitions before scanning.
- Retention is `DROP PARTITION p2024_10` — an O(partition) metadata
  operation instead of a `DELETE` cartesian scan.
- Backups can be MariaBackup/`mysqlpump` per partition on modern MySQL.
- Idempotency keys are only unique **within** a partition unless the
  `UNIQUE(idempotency_key)` index spans all partitions (see below).

**The must-know MySQL constraint:** every `UNIQUE` and `PRIMARY` key must
**include all partition columns**. `UNIQUE(idempotency_key)` therefore has to
change to:

```sql
PK  (idempotency_key, usage_date)          -- makes the PK pruning-compatible
UNIQUE(idempotency_key, usage_date)        -- same constraint, partition-aware
```

The idempotency check becomes `WHERE idempotency_key = ? AND usage_date = ?`.
Trade-off: a key collision is now only detected for the same `usage_date`.
This is acceptable for metering (retry of the same day) and is the standard
production trade-off for partitioned billing tables.

> If you *must* enforce global idempotency, move the enforcement to
> `daily_usage` (the upsert key `UNIQUE(customer_id, usage_date)`) and treat
> raw `usage_events` as append-only telemetry. This is the recommended middle
> ground and keeps the raw table free of cross-partition constraints.

### 3.2 Partition the support tables too

After `usage_events`, `invoices` is the next table whose history grows
perpetually. Monthly RANGE partitions on `period_start` give you free
retention pruning and keep the unique `(subscription_id, period_start,
period_end)` constraint partition-local (period boundaries map to a single
month partition).

`daily_usage` can be partitioned, but because it is a heavily upserted,
hot-read table you usually get more benefit from **table size discipline**
(see §5) than from a partition. If you partition it, RANGE on `usage_date`
again, and keep `UNIQUE(customer_id, usage_date)` aligned with the partition
column.

### 3.3 HASH partitioning (only for write-only sharding)

HASH partitioning by `customer_id` spreads writes but does **not** make your
read queries faster (metrics queries scan by `usage_date`, and a date filter
touches every partition). Reserve hash partitioning for the *ingest buffer*
stage described in §6.

---

## 4. Denormalization strategy

Denormalization is used where read-heavy queries need answers in
milliseconds while the source of truth stays normalized.

### 4.1 `daily_usage` — the canonical pre-aggregate

| Column | Purpose |
|---|---|
| `customer_id`, `usage_date` | Grain of the row (unique key) |
| `units` | Total metered units for that customer/day |

**Upsert, don't append.** The aggregation job runs `updateOrCreate` so late-
arriving events re-sum the day without double counting:

```php
DailyUsage::updateOrCreate(
    ['customer_id' => $id, 'usage_date' => $date],
    ['units' => (int) $sum]
);
```

**Why this table makes dashboards and invoices cheap**

- Dashboard "top 5 by usage" = `GROUP BY customer_id` over one partition of
  `daily_usage` (≤ 31 rows per customer per month).
- Invoice usage per segment = `SUM(units)` over a date range on
  `daily_usage` — no raw events touched.

### 4.2 Next denormalization step: monthly rollups

As `daily_usage` itself grows, add a second aggregate at monthly grain:

```sql
CREATE TABLE monthly_usage (
  customer_id BIGINT UNSIGNED NOT NULL,
  usage_month DATE NOT NULL,             -- first day of month
  units BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (customer_id, usage_month),
  KEY idx_month (usage_month, customer_id, units)
) ENGINE=InnoDB;
```

The churn-risk metric (MoM usage drop) then reads `monthly_usage` instead of
scanning 12 months of `daily_usage`. Keep it current in the same aggregation
job that maintains `daily_usage`:

```sql
INSERT INTO monthly_usage (customer_id, usage_month, units)
SELECT customer_id, DATE(DATE_FORMAT(usage_date,'%Y-%m-01')), SUM(units)
FROM daily_usage
WHERE usage_date BETWEEN ? AND ?
GROUP BY customer_id, usage_month
ON DUPLICATE KEY UPDATE units = VALUES(units);
```

### 4.3 Materialized dashboard summary

For very hot dashboard endpoints, maintain `customer_current_cycle`:

```sql
CREATE TABLE customer_cycle_stats (
  merchant_id        BIGINT UNSIGNED NOT NULL,
  customer_id        BIGINT UNSIGNED NOT NULL,
  cycle_start        DATE NOT NULL,
  cycle_end          DATE NOT NULL,
  units_used         BIGINT UNSIGNED NOT NULL DEFAULT 0,
  projected_overage  DECIMAL(14,4) NOT NULL DEFAULT 0,
  PRIMARY KEY (customer_id, cycle_start),
  KEY idx_merchant_usage (merchant_id, units_used DESC)
);
```

The dashboard endpoint becomes a single indexed read. Recompute it nightly (or
hourly) via the aggregation pipeline; accept that it is eventually consistent
by design.

---

## 5. Retention, compaction, and archival

1. **Partition drop** — `ALTER TABLE usage_events DROP PARTITION p2024_10;`
   instantly purges a month. This is why partitioning is non-negotiable at
   scale.
2. **Archive (not delete) raw events** for legal/billing disputes. Ship
   monthly partitions to cold storage (S3/Parquet via a clone + ingest into
   data lake) before dropping.
3. **`daily_usage` compaction** — a customer with >1 active cycle can have its
   old daily rows folded into `monthly_usage`, then purged.
4. **`invoices`** are legally sensitive → never purge; keep forever, partition
   for pruning cost only.

---

## 6. Write-path / ingest architecture at 50M+ events/month

Queues and caching do not remove the need for fast writes. The pattern below
scales writes while preserving idempotency:

```
Clients ──► API Gateway ──► POST /api/usage (rate-limited)
                                  │
                                  ▼
                         ingest buffer (optional)
                         Redis Stream / Kafka / Laravel queue
                                  │  (batched consumer)
                                  ▼
                        usage_events  ──►  (daily job)
                                              ▼
                                    GROUP BY customer_id
                                              ▼
                                          daily_usage
```

- **Batch the idempotency check into the insert.** For an upsert-tolerant
  design, use `INSERT ... ON DUPLICATE KEY UPDATE` with the unique key —
  retries are then naturally idempotent.
- **Buffer spikes.** Route `POST /api/usage` into a Redis Stream / queue and
  consume in batches (e.g. 1,000 events per transaction). The
  `AggregateDailyUsageJob` is `ShouldBeUnique` per date, so burst traffic
  cannot queue a thousand duplicate aggregation jobs for the same day.
- **Eventual consistency window.** `daily_usage` lags raw ingestion by the
  queue drain time. Dashboards label figures "as of last aggregation run".

### Suggested deployment profile

| Stage | DB | Queue/cache | Workers | Notes |
|---|---|---|---|---|
| Demo / <1M rows | MySQL (XAMPP) | database driver | single | Current repo default |
| 1–10M rows | MySQL 8 | Redis | 2–4 `queue:work` | `REDIS_HOST` in `.env` |
| 10M+ rows | MySQL 8 partitioned | Redis Streams + Laravel | auto-scaled pool | Buffer ingest, partition monthly |
| 50M+ rows | MySQL/Percona + replicas | Kafka or Redis Streams | dedicated ingestion service | Read replicas serve dashboards & invoices |

### Read/write split

Point dashboard and invoice-generation traffic at replica reads:

```env
DB_READ_HOST=replica.internal
```

Add a second connection (`config/database.php`) with `'read' => [...]` and
route dashboard queries through it. Writes (usage ingestion, aggregation
upserts) stay on the primary to avoid split-brain consistency on invoice math.

---

## 7. Caching strategy

- **Plans / pricing** — `Cache::remember("plan:{id}", …)` with **eager
  invalidation** on save/delete via the `Plan` model observer
  (`Plan::forget`). Use Redis once `CACHE_STORE=database` becomes a hot
  path.
- **Dashboard aggregates** — cache the computed summary in Redis for 60s–5m,
  keyed `dashboard:{merchant_id}:{cycle_start}`; invalidate on aggregation
  completion for that day.
- **Never cache** invoices, usage events, or idempotency keys — they must be
  durable and unambiguous.
- Use **Cache tags** (Redis) to flush all plan-derived keys with one call if
  tags are available on your store.

### Env switch

```env
# database cache is perfect for the demo/XAMPP path
CACHE_STORE=database

# production
CACHE_STORE=redis
REDIS_CLIENT=phpredis
REDIS_HOST=127.0.0.1
REDIS_PORT=6379
```

---

## 8. Monitoring checkpoints (recommended at every stage)

- **Ingest lag:** time between `usage_events.created_at` max and the last
  completed aggregation `usage_date`. Alert if > 24h.
- **Partition headroom:** size of the `pfuture`/current partition vs.
  threshold; auto-create the next month's partition in a nightly scheduled job.
- **Idempotency hit-rate:** share of `POST /api/usage` responses with
  `duplicate: true` — high share ≥ 30% usually means clients retry
  aggressively; raise `throttle:ingestion` or add exponential backoff.
- **Overage projection drift:** compare projected overage (dashboard) vs.
  actual invoiced overage at cycle close; drift exposes missing aggregation.

## 9. Migration plan (checklist)

1. [ ] Add covering index `(usage_date, customer_id, units)`.
2. [ ] Enable RANGE partitioning on `usage_events` by `usage_date`;
   align PK/unique keys with the partition column.
3. [ ] Introduce `monthly_usage` rollups; route churn metrics to it.
4. [ ] Introduce `customer_cycle_stats`; compute via nightly job.
5. [ ] Move cache and queue to Redis; enable replica reads for dashboards.
6. [ ] Test `DROP PARTITION` retention runbook on a staging copy.