# Mallow Billing — Multi-tenant Subscription Billing & Usage Metering

A Laravel 12 backend for **multi-tenant subscription billing** and
**high-volume metering**. Merchants configure plans with base prices, billing
cycles, included allowances and overage rates; customers subscribe to plans;
usage events are ingested **idempotently at high throughput**, aggregated
asynchronously into daily rollups, and invoiced each cycle with accurate
day-level **proration** and **plan-change splitting**.

Built to run out of the box on **Windows + XAMPP + MySQL**, and scaled for
**5M+ usage-event rows** with partitioning, denormalized aggregates and Redis
caching (see [SCALING.md](SCALING.md)).

---

## Feature checklist

| Requirement | Implementation |
|---|---|
| Multi-tenant merchants + custom plans | `merchants`, `plans` |
| Customer subscriptions to merchant plans | `customers`, `subscriptions` |
| Normalized, indexed schema for 50L+ rows | 8 business tables + composite indexes |
| Scaling / denormalization / partitioning docs | [SCALING.md](SCALING.md) |
| Idempotent high-throughput `POST /usage` | Unique `idempotency_key` + `firstOrCreate` |
| Rate limiting on ingestion | Named `throttle:ingestion` limiter (120 req/min/IP, configurable) |
| Queued, chunked daily aggregation | `AggregateDailyUsageJob` (unique per date) → `UsageAggregationService` |
| Cycle-end invoice generation | `InvoiceService` + `BillingCalculator` |
| Proration for mid-cycle starts | Day-ratio pro-rating of base + allowance |
| Mid-cycle upgrades / downgrades | `subscription_segments` split usage across plans |
| Plan/pricing cache (Redis/array) with invalidation | `Plan::cached()` + save/delete observer |
| Merchant dashboard (HTML + JSON) | `GET /` (HTML) + `GET /api/merchants/{id}/dashboard` (JSON) — Top-5 users, projected overage (INR), churn-risk (>50% MoM drop) |
| Automated tests | 45 tests (billing, aggregation, proration, overage, ingestion, cache) |

---

## Architecture

```
                    ┌────────────────────────────────────────────┐
 POST /api/usage ──►│ UsageController (validates, rate-limited)  │
                    │   ├─ firstOrCreate (idempotent insert)      │
                    │   └─ dispatch AggregateDailyUsageJob        │
                    └──────────────────────┬─────────────────────┘
                                           ▼
                              AggregateDailyUsageJob (ShouldBeUnique)
                                           ▼
                            UsageAggregationService.aggregateDate()
                         GROUP BY customer_id  →  daily_usage (upsert)
                                           ▼
  POST /api/subscriptions/{id}/invoice ──► InvoiceService
                         segments.plan + daily_usage
                                           ▼
                              BillingCalculator (pure math)
                             proratedSegment() + combine()
                                           ▼
                                        invoices
```

Layers:

- **HTTP layer** (`app/Http/Controllers`) — validation and responses only.
- **Domain services** (`app/Services`) — `BillingCalculator` (pure math),
  `UsageAggregationService`, `InvoiceService`.
- **Jobs** (`app/Jobs`) — queued aggregation, deduplicated per date.
- **Data** (`app/Models`, `database/migrations`) — Eloquent + indexed schema.

---

## Tech stack

- **PHP 8.2+ / Laravel 12**
- **MySQL** (8.x) primary; **SQLite** for the test suite
- **Redis** optional (cache + queue); defaults to database drivers for XAMPP
- **Laravel Pint** (code style), **PHPUnit** (tests)

---

## Setup (Windows + XAMPP + MySQL)

Requirements: XAMPP (Apache + MySQL), PHP 8.2+, Composer.

```bat
cd C:\xampp\htdocs
composer create-project laravel/laravel mallow-billing
cd mallow-billing
```

Copy the project files into place, then:

```sql
CREATE DATABASE mallow_billing CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

Configure `.env`:

```env
APP_NAME="Mallow Billing"
APP_URL=http://127.0.0.1:8000

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=mallow_billing
DB_USERNAME=root
DB_PASSWORD=

CACHE_STORE=database      # switch to redis for production
QUEUE_CONNECTION=database # switch to redis for production
```

Run:

```bat
php artisan key:generate
php artisan migrate --seed
php artisan serve
```

Start the queue worker in a second terminal:

```bat
php artisan queue:work
```

Open http://127.0.0.1:8000. See `INSTALL_ON_XAMPP.txt` for a step-by-step
walkthrough.

### Optional: Redis

```env
CACHE_STORE=redis
QUEUE_CONNECTION=redis
REDIS_CLIENT=phpredis     # or predis
REDIS_HOST=127.0.0.1
REDIS_PORT=6379
```

---

## API

### `POST /api/usage` — record usage (rate-limited, idempotent)

```json
{
  "customer_id": 1,
  "usage_date": "2026-09-15",
  "units": 100,
  "idempotency_key": "order-9f2c-usage-001"
}
```

Responses:

- `201` — newly recorded event (`duplicate: false`)
- `200` — the `idempotency_key` was already seen (`duplicate: true`); the
  original event is returned and is **not** double counted
- `422` — validation failure
- `429` — rate limit exceeded (default 120 req/min per IP)

The unique `idempotency_key` guarantees retries are safe even under concurrent
duplicate delivery.

### `GET /` — merchant dashboard (HTML)

The application home page renders a live merchant dashboard styled in Indian
rupee (INR) formatting. It shows KPI cards (top customer MTD usage, projected
overage revenue, churn-risk count), a top-5 customer usage table with
gold/silver/bronze ranking, and a churn-risk table with drop-rate bars.
Switch merchants via the dropdown (uses `?merchant={id}`).

Both this page and the JSON endpoint below are powered by the shared
`DashboardMetricsService`.

### `GET /api/merchants/{id}/dashboard` — merchant dashboard (JSON)

Returns:

- `top_5_customers_by_usage_this_month`
- `projected_overage_revenue_current_cycle`
- `usage_drop_over_50_percent_month_over_month` (churn-risk customers)

### `POST /api/subscriptions/{id}/invoice` — generate an invoice

```json
{
  "period_start": "2026-09-01",
  "period_end": "2026-09-30"
}
```

Returns the computed (idempotent per subscription+period) invoice.

```json
{
  "success": true,
  "invoice": {
    "base_amount": "100.00",
    "included_units": 1000,
    "used_units": 1200,
    "overage_units": 200,
    "overage_amount": "20.00",
    "total_amount": "120.00",
    "status": "final"
  }
}
```

---

## Billing model & assumptions

- **Cycle** runs from the subscription start day through the day before the
  next monthly anniversary.
- **Day-level proration**: `active_days / total_days` of the billing cycle is
  applied to both the base price and the included allowance.
- **Included allowance is floored**, not rounded (`floor(included × ratio)`).
- **Overage** = `max(0, used − prorated allowance) × overage_rate`, rounded to
  two decimals on the amount.
- **Mid-cycle plan changes** create `subscription_segments`. Each segment is
  billed with its own plan's rate and allowance, prorated over its window;
  usage is attributed to a segment by `usage_date`. Both upgrade and downgrade
  paths are supported and tested.
- **Mid-cycle subscription starts** are prorated automatically (the segment
  window inside the invoice period drives the ratio).

---

## Queues & background jobs

| Job | Purpose | Dedup |
|---|---|---|
| `AggregateDailyUsageJob` | Recompute `daily_usage` for a date | `ShouldBeUnique` per date |

The job walks distinct customers for the date with a single `GROUP BY
customer_id, SUM(units)` query, chunking results (`aggregation_chunk_size`,
default 500) and upserting into `daily_usage`. Because the job is unique per
date, a burst of thousands of usage events enqueues exactly one aggregation.

Manual kickoff:

```bat
php artisan tinker --execute="\App\Jobs\AggregateDailyUsageJob::dispatchSync('2026-09-15');"
```

---

## Caching & invalidation

- Plan/pricing lookups use `Plan::cached($id)` →
  `Cache::remember("plan:$id", plan_cache_ttl_seconds)`.
- **Invalidation strategy:** the `Plan` model observer calls `Plan::forget()`
  on `saved`/`deleted`, so edited pricing is reflected immediately after
  commit. Manual invalidation:

  ```bat
  php artisan tinker --execute="\App\Models\Plan::forget(1);"
  ```

- TTL and limits are configurable via `config/billing.php` (`USAGE_RATE_LIMIT_PER_MINUTE`,
  `PLAN_CACHE_TTL_SECONDS`, `AGGREGATION_CHUNK_SIZE`).

---

## Scaling to 50M+ usage rows

The schema is normalized with composite indexes and a `daily_usage`
pre-aggregate. See **[SCALING.md](SCALING.md)** for the full playbook:

- covering indexes for aggregation
- monthly RANGE partitioning by `usage_date` (+ the unique-key rule)
- second-level denormalization (`monthly_usage`, `customer_cycle_stats`)
- retention via `DROP PARTITION`
- write-path buffering and replica reads
- cache strategy and monitoring checkpoints

---

## Testing

```bat
php artisan test
```

45 tests / 151 assertions covering:

- **Billing math:** full cycles, zero usage, overage rounding, allowance
  flooring, leap-year proration, single-day cycles, out-of-cycle clamps.
- **Proration:** mid-cycle starts, restarts, prorated overage.
- **Plan changes:** upgrade and downgrade with usage split across segments.
- **Aggregation:** multi-event sums, multiple customers, idempotent reruns,
  late-arriving events, date isolation.
- **Ingestion:** idempotency (retry/different payload), validation, rate
  limit (429).
- **Invoices:** full-cycle, overage, proration, idempotent same-period
  regeneration, inverted-range validation.
- **Dashboard:** top-5 ordering, overage projection, churn risk flagging,
  tenant scoping.
- **Caching:** cache hit, invalidation on save/delete, manual forget.

Use `--filter` to run one area, e.g.:

```bat
php artisan test --filter=UsageAggregationServiceTest
```

Also runs clean on PHPUnit:

```bat
vendor\bin\phpunit
```

---

## Project structure

```
app/
  Http/Controllers/     UsageController, InvoiceController, DashboardController, HomeController
  Jobs/                 AggregateDailyUsageJob
  Models/               Merchant, Plan, Customer, Subscription,
                        SubscriptionSegment, UsageEvent, DailyUsage, Invoice
  Services/             BillingCalculator, UsageAggregationService, InvoiceService,
                        DashboardMetricsService
config/billing.php      rate limit, cache TTL, aggregation chunk size
database/
  migrations/           8 business tables (+ Laravel defaults)
  factories/            Factories for every business model
  seeders/              Demo merchant + 2 plans + 8 customers + deterministic usage
                        patterns with pre-populated daily_usage (no queue needed
                        for dashboard demo data)
resources/views/
  dashboard.blade.php   Colorful self-contained HTML dashboard (no Vite/npm build)
routes/web.php          GET / → HomeController (merchant dashboard HTML)
routes/api.php          API surface
tests/                  Unit (billing, aggregation) + Feature (API, cache)
SCALING.md              Scaling, denormalization, partitioning playbook
```

---

## Production checklist

- [ ] Move `CACHE_STORE` / `QUEUE_CONNECTION` to Redis.
- [ ] Run ≥ 2 `queue:work` workers (or Horizon for Redis).
- [ ] Add authentication (Sanctum/API tokens) and tenant-scope all queries.
- [ ] Follow SCALING.md migration plan before exceeding ~1M rows.
- [ ] Configure replica reads for dashboards/invoices.
- [ ] Set `APP_DEBUG=false`, `APP_ENV=production`.
- [ ] Scheduled job to pre-create partitions and run retention drops.

## License

MIT