<?php

namespace App\Jobs;

use App\Services\UsageAggregationService;
use Carbon\Carbon;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;

class AggregateDailyUsageJob implements ShouldQueue, ShouldBeUnique
{
    use Queueable;

    /**
     * The number of seconds to keep the aggregation lock after the job finishes.
     * Prevents a burst of usage events for the same date from re-running the
     * (idempotent) aggregation repeatedly.
     */
    public int $uniqueFor = 30;

    public function __construct(public string $usageDate)
    {
    }

    /**
     * Only one aggregation job may be queued/in-flight per usage date.
     */
    public function uniqueId(): string
    {
        return $this->usageDate;
    }

    public function handle(UsageAggregationService $service): void
    {
        $service->aggregateDate(Carbon::parse($this->usageDate));
    }
}
