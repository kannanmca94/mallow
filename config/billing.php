<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Usage Endpoint Rate Limit
    |--------------------------------------------------------------------------
    |
    | Maximum number of POST /api/usage requests a single IP may issue per
    | minute. This is a coarse safeguard against floods and abusive retries;
    | production systems should replace IP-keyed limits with per-tenancy
    | API-key (or per-customer) limits enforced at the gateway.
    |
    */

    'usage_rate_limit_per_minute' => env('USAGE_RATE_LIMIT_PER_MINUTE', 120),

    /*
    |--------------------------------------------------------------------------
    | Plan Cache TTL (seconds)
    |--------------------------------------------------------------------------
    |
    | How long plan/pricing lookups are cached before being refreshed.
    | When billing rates change, the cache is eagerly invalidated on every
    | Plan save/delete via the Plan model observer.
    |
    */

    'plan_cache_ttl_seconds' => env('PLAN_CACHE_TTL_SECONDS', 3600),

    /*
    |--------------------------------------------------------------------------
    | Usage Aggregation
    |--------------------------------------------------------------------------
    |
    | Chunk size used when walking raw usage_events rows during the daily
    | aggregation job. Smaller chunks use less memory per worker; larger
    | chunks reduce round-trips on fast connections.
    |
    */

    'aggregation_chunk_size' => env('AGGREGATION_CHUNK_SIZE', 500),
];
