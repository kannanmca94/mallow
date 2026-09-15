# AI Prompt Log

> Placeholder: replace with your own generative-AI conversation transcripts as
> required for the assignment. Everything here documents the prompts provided
> to the AI coding assistant and the reasoning behind the resulting
> implementation in this repository.

## 1. System prompt (single consolidated brief)

The project brief delivered as one request to the AI:

> Design a multi-tenant backend for subscription billing and high-volume
> usage metering.
>
> - Model Merchants (tenants) who configure plans with base prices, billing
>   cycles, included allowances, and overage rates.
> - Enable Customers to subscribe to a merchant's designated plan.
> - Create a normalized, indexed database schema capable of handling 50L+
>   (5 million+) usage-event rows.
> - Provide documentation for schema scaling, denormalization, and data
>   partitioning strategies.
> - Build an idempotent, high-throughput `POST /usage` endpoint to ingest
>   daily customer usage events without double-counting.
> - Implement basic rate-limiting safeguards on the usage recording endpoint.
> - Set up queued, chunked background jobs to aggregate daily usage records
>   per customer.
> - Implement cycle-end invoice generation calculating base price, allowance
>   usage, and overage fees.
> - Calculate accurate billing proration for mid-cycle customer subscription
>   starts.
> - Handle mid-cycle plan upgrades and downgrades by accurately splitting
>   usage across segments and prorating both rates.
> - Cache plan and pricing lookups via Redis or array drivers with a defined
>   invalidation strategy.
> - Build a `GET /merchants/{id}/dashboard` endpoint displaying top 5 users,
>   projected overage revenue, and churn-risk customers (>50% MoM drop).
> - Write automated tests covering aggregation, billing math, proration, and
>   overage edge cases.
> - Deliver a GitHub repository with a production-grade README, an AI prompt
>   log (if applicable), and a 5–10 minute narrated walkthrough video.

## 2. Follow-up prompts (selected)

| # | Prompt / direction | Decision implemented |
|---|---|---|
| 01 | "Explore the existing codebase and report framework, structure, migrations, services, routes, and tests." | Confirmed Laravel 12 stack; found `routes/api.php` was not registered in `bootstrap/app.php`. |
| 02 | "Fix the API routes not being loaded." | Added `api: .../routes/api.php` to `withRouting()` in `bootstrap/app.php`. |
| 03 | "Use a single GROUP BY aggregation pass instead of per-customer N+1 queries." | Rewrote `UsageAggregationService::aggregateDate()`; chunked with configurable size. |
| 04 | "Prevent duplicate aggregation jobs for the same date under burst traffic." | Added `ShouldBeUnique` with `uniqueId()` = usage date to `AggregateDailyUsageJob`. |
| 05 | "Add a named, configurable rate limiter for the ingestion endpoint." | Added `RateLimiter::for('ingestion', ...)` in `AppServiceProvider`; route now uses `throttle:ingestion`; limit from `config/billing.php`. |
| 06 | "Cache plan lookups with an eager invalidation strategy on save/delete." | `Plan::cached()` + `Plan::forget()` via `saved`/`deleted` model observers; TTL configurable. |
| 07 | "Make the calculator clamp out-of-cycle segments defensively." | `BillingCalculator::proratedSegment()` now clamps the active window to the billing cycle; covered by unit tests. |
| 08 | "Fix DATE-column storage for SQLite/MySQL parity." | Removed `date` casts that wrote `00:00:00` into DATE columns on `UsageEvent`, `DailyUsage`, `Invoice`; set explicit `$table` on `DailyUsage`. |
| 09 | "Document scaling, denormalization, and partitioning strategies for 50M+ rows." | Wrote `SCALING.md`: covering indexes, monthly RANGE partitions, unique-key rule, rollups, retention, write-path buffering, replica reads, caching, monitoring. |
| 10 | "Cover edge cases in tests." | Added 45 tests: overage rounding, allowance flooring, leap year, idempotency (same/different payload), rate-limit 429, plan upgrade/downgrade split, invoice period idempotency, cache invalidation. |
| 11 | "I need merchant dashboard when I open the application" | Created `HomeController`, `DashboardMetricsService`, and `resources/views/dashboard.blade.php`. Routes `GET /` to HTML dashboard; the service is shared between the HTML page and the JSON API endpoint. |
| 12 | "Make it for dashboard sample data to show" | Updated `DatabaseSeeder` to write deterministic `daily_usage` rows directly (no queue required for demo). Includes churn-risk demo: Customer 5 has high last-month usage that drops >50% this month. All amounts in INR. |
| 13 | "All cost are INR make it correct not other currency" | Replaced `$` currency symbol with `₹` on the dashboard overage-revenue card. |
| 14 | "Make it colourful dashboard" | Rebuilt `dashboard.blade.php` with gradient hero bar, colored KPI cards (blue/green/red), gold/silver/bronze rank badges, animated drop-rate bars, Inter font, hover effects, and mobile responsive layout. |

## 3. Verification requests

- "Run the full suite and confirm all tests pass." → `php artisan test`
  (currently 45 passed / 151 assertions).
- "Run code style checks." → `php artisan pint` (PSR-12).

## Screenshots

Add your actual prompt screenshots here before submission:

- `prompts/01-architecture.png`
- `prompts/02-schema.png`
- `prompts/03-billing.png`
- `prompts/04-tests.png`

## Walkthrough video

A 5–10 minute narrated walkthrough is expected. Suggested outline:

1. Requirements and architecture (1–2 min)
2. Schema walkthrough and scaling plan (2 min)
3. Usage ingestion + idempotency + rate limiting (1–2 min)
4. Aggregation job and caching (1 min)
5. Invoice generation, proration, plan changes (2 min)
6. Dashboard + demo with the seeded data (1–2 min)
7. Running the test suite (1 min)