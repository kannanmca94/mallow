<?php

namespace App\Services;

use App\Models\DailyUsage;
use App\Models\UsageEvent;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class UsageAggregationService
{
    /**
     * Aggregates all usage events for a given date into the daily_usage table.
     *
     * Uses a single GROUP BY pass (one row per customer) rather than an N+1
     * per-customer scan, which keeps the aggregation cost linear in the number
     * of active customers rather than the number of raw events.
     */
    public function aggregateDate(Carbon $date): int
    {
        $processed = 0;
        $chunkSize = (int) config('billing.aggregation_chunk_size', 500);

        UsageEvent::query()
            ->select('customer_id', DB::raw('SUM(units) as total_units'))
            ->whereDate('usage_date', $date)
            ->groupBy('customer_id')
            ->orderBy('customer_id')
            ->chunk($chunkSize, function ($rows) use ($date, &$processed) {
                foreach ($rows as $row) {
                    DailyUsage::updateOrCreate(
                        [
                            'customer_id' => $row->customer_id,
                            'usage_date' => $date->toDateString(),
                        ],
                        ['units' => (int) $row->total_units]
                    );
                    $processed++;
                }
            });

        return $processed;
    }
}
