<?php

namespace App\Services;

use Carbon\Carbon;
use Illuminate\Support\Collection;

class BillingCalculator
{
    public function proratedSegment(
        float $basePrice,
        int $includedUnits,
        float $overageRate,
        Carbon $segmentStart,
        Carbon $segmentEnd,
        Carbon $cycleStart,
        Carbon $cycleEnd,
        int $usedUnits
    ): array {
        $totalDays = max(
            1,
            $cycleStart->copy()->startOfDay()->diffInDays($cycleEnd->copy()->startOfDay()) + 1
        );

        // Clamp the segment's active window to the billing cycle so that a
        // segment which falls partially or entirely outside the cycle is
        // billed only for the days that actually overlap it.
        $segStartDay = $segmentStart->copy()->startOfDay();
        $segEndDay = $segmentEnd->copy()->startOfDay();
        $cycleStartDay = $cycleStart->copy()->startOfDay();
        $cycleEndDay = $cycleEnd->copy()->startOfDay();

        $effectiveStart = $segStartDay->greaterThan($cycleStartDay) ? $segStartDay : $cycleStartDay;
        $effectiveEnd = $segEndDay->lessThan($cycleEndDay) ? $segEndDay : $cycleEndDay;

        $activeDays = $effectiveEnd->gte($effectiveStart)
            ? (int) $effectiveStart->diffInDays($effectiveEnd) + 1
            : 0;

        $ratio = min(1, $activeDays / $totalDays);

        $base = round($basePrice * $ratio, 2);
        $included = (int) floor($includedUnits * $ratio);
        $overageUnits = max(0, $usedUnits - $included);
        $overage = round($overageUnits * $overageRate, 2);

        return [
            'base_amount' => $base,
            'included_units' => $included,
            'used_units' => $usedUnits,
            'overage_units' => $overageUnits,
            'overage_amount' => $overage,
            'total_amount' => round($base + $overage, 2),
        ];
    }

    public function combine(Collection $segments): array
    {
        $out = [
            'base_amount' => 0, 'included_units' => 0, 'used_units' => 0,
            'overage_units' => 0, 'overage_amount' => 0, 'total_amount' => 0
        ];
        foreach ($segments as $segment) {
            foreach ($out as $key => $_) {
                $out[$key] += $segment[$key];
            }
        }
        $out['base_amount'] = round($out['base_amount'], 2);
        $out['overage_amount'] = round($out['overage_amount'], 2);
        $out['total_amount'] = round($out['total_amount'], 2);
        return $out;
    }
}
