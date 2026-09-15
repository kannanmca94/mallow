<?php

namespace App\Services;

use App\Models\Invoice;
use App\Models\Subscription;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class InvoiceService
{
    public function __construct(private BillingCalculator $calculator)
    {
    }

    public function generate(Subscription $subscription, Carbon $periodStart, Carbon $periodEnd): Invoice
    {
        $subscription->load(['customer','segments.plan','plan']);

        $segments = $subscription->segments->filter(function ($s) use ($periodStart, $periodEnd) {
            $from = Carbon::parse($s->effective_from);
            $to = $s->effective_to ? Carbon::parse($s->effective_to) : $periodEnd;
            return $from->lte($periodEnd) && $to->gte($periodStart);
        });

        if ($segments->isEmpty()) {
            $segments = collect([tap((object)[], function ($s) use ($subscription, $periodStart) {
                $s->plan = $subscription->plan;
                $s->effective_from = $periodStart;
                $s->effective_to = null;
            })]);
        }

        $parts = [];
        foreach ($segments as $segment) {
            $segStart = max($periodStart->copy(), Carbon::parse($segment->effective_from));
            $segEnd = min($periodEnd->copy(), $segment->effective_to ? Carbon::parse($segment->effective_to) : $periodEnd);

            $used = (int) DB::table('daily_usage')
                ->where('customer_id', $subscription->customer_id)
                ->whereBetween('usage_date', [$segStart->toDateString(),$segEnd->toDateString()])
                ->sum('units');

            $parts[] = $this->calculator->proratedSegment(
                (float)$segment->plan->base_price,
                (int)$segment->plan->included_units,
                (float)$segment->plan->overage_rate,
                $segStart,
                $segEnd,
                $periodStart,
                $periodEnd,
                $used
            );
        }

        $totals = $this->calculator->combine(collect($parts));

        return Invoice::updateOrCreate(
            ['subscription_id' => $subscription->id,'period_start' => $periodStart->toDateString(),'period_end' => $periodEnd->toDateString()],
            $totals + ['status' => 'final']
        );
    }
}
