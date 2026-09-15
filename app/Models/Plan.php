<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Cache;

class Plan extends Model
{
    use HasFactory;
    /** Cache TTL for plan/pricing lookups (seconds before a refresh is forced). */
    public const CACHE_TTL = 3600;

    protected $fillable = [
        'merchant_id','name','base_price','billing_cycle',
        'included_units','overage_rate'
    ];

    protected $casts = [
        'base_price' => 'decimal:2',
        'overage_rate' => 'decimal:4',
        'included_units' => 'integer',
    ];

    protected static function booted(): void
    {
        // Invalidate the cached plan whenever it is saved, updated, or deleted.
        static::saved(fn (Plan $plan) => static::forget($plan->id));
        static::deleted(fn (Plan $plan) => static::forget($plan->id));
    }

    public static function cacheKey(int $id): string
    {
        return "plan:$id";
    }

    public static function cached(int $id): self
    {
        $ttl = (int) config('billing.plan_cache_ttl_seconds', self::CACHE_TTL);

        return Cache::remember(
            static::cacheKey($id),
            now()->addSeconds($ttl),
            fn () => static::findOrFail($id)
        );
    }

    public static function forget(int $id): void
    {
        Cache::forget(static::cacheKey($id));
    }

    public function merchant()
    {
        return $this->belongsTo(Merchant::class);
    }
}
