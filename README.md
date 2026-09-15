# Mallow Billing 🚀

**Multi-Tenant Subscription Billing & Usage Metering** built with **Laravel 12, PHP 8.2+, MySQL, Redis, and Laravel Queues**.

Designed for SaaS applications that require subscription management, high-volume usage tracking, proration, overage billing, and invoice generation.

## ✨ Features

* 🏢 Multi-tenant merchants & customers
* 💳 Custom subscription plans
* 📊 High-volume usage metering
* 🔐 Idempotent `POST /api/usage`
* 🚦 Rate limiting
* ⚡ Asynchronous daily usage aggregation
* 🔄 Mid-cycle plan upgrades/downgrades
* 📅 Day-level billing proration
* 💰 Overage calculation & invoicing
* 📈 Merchant dashboard & churn-risk analytics
* 🚀 Redis caching & queue support
* 🧪 PHPUnit automated tests
* 📦 Designed for 5M+ usage-event rows

## 🛠️ Tech Stack

```text
PHP 8.2+
Laravel 12
MySQL 8
Redis
Laravel Queue
Eloquent ORM
PHPUnit
Blade
```

## ⚡ Quick Start — XAMPP / Windows

cd C:\xampp\htdocs

composer create-project laravel/laravel mallow-billing
cd mallow-billing

php artisan key:generate
php artisan migrate --seed
php artisan serve


Open: http://127.0.0.1:8000

Start queue worker:

php artisan queue:work

Run tests:

php artisan test

## 🔌 API

### Record Usage

```http
POST /api/usage
```

```json
{
  "customer_id": 1,
  "usage_date": "2026-09-15",
  "units": 100,
  "idempotency_key": "usage-001"
}
```

### Dashboard

GET /api/merchants/{id}/dashboard

### Generate Invoice

POST /api/subscriptions/{id}/invoice

## 🏗️ Architecture

API
 │
 ▼
Controllers
 │
 ▼
Domain Services
 │
 ├── BillingCalculator
 ├── InvoiceService
 ├── UsageAggregationService
 └── DashboardMetricsService
 │
 ▼
MySQL + Redis
 │
 ▼
Laravel Queue


## 📚 Documentation

* `INSTALL_ON_XAMPP.txt` — Windows/XAMPP setup
* `SCALING.md` — 5M+ usage-event scaling strategy

## 📄 License

MIT License
