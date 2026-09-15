<?php

namespace App\Providers;

use Illuminate\Cache\RateLimiting\Limit;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\ServiceProvider;
use Illuminate\Http\Request;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // Named rate limiter for the high-throughput usage ingestion endpoint.
        // Limits are applied per IP; the default of 120 req/min acts as a
        // coarse safeguard against accidental floods or abusive clients.
        // Bump the limit (or move to per-tenant API-key limiting) for
        // higher-volume production ingest.
        RateLimiter::for('ingestion', function (Request $request) {
            return Limit::perMinute((int) config('billing.usage_rate_limit_per_minute', 120))
                ->by($request->ip());
        });
    }
}
