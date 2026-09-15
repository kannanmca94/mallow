<?php

namespace App\Services;

use App\Models\Customer;
use App\Models\Merchant;
use App\Models\Plan;
use App\Models\Subscription;
use Illuminate\Support\Facades\DB;

class DashboardMetricsService
{
    /**
     * Computes the merchant dashboard metrics:
     * top 5 customers by current-cycle usage, projected overage revenue,
     * and customers whose usage dropped more than 50% month-over-month.
     */
    public function forMerchant(Merchant $merchant): array
    {
        $start = now()->startOfMonth()->toDateString();
        $end = now()->toDateString();
        $previousStart = now()->subMonth()->startOfMonth()->toDateString();
        $previousEnd = now()->subMonth()->endOfMonth()->toDateString();

        $topCustomers = Customer::query()
            ->join('daily_usage', 'daily_usage.customer_id', '=', 'customers.id')
            ->where('customers.merchant_id', $merchant->id)
            ->whereBetween('daily_usage.usage_date', [$start, $end])
            ->select(
                'customers.id',
                'customers.name',
                'customers.email',
                DB::raw('SUM(daily_usage.units) as total_units')
            )
            ->groupBy('customers.id', 'customers.name', 'customers.email')
            ->orderByDesc('total_units')
            ->limit(5)
            ->get();

        $activeSubscriptions = Subscription::query()
            ->with('plan')
            ->whereHas('customer', fn ($q) => $q->where('merchant_id', $merchant->id))
            ->where('status', 'active')
            ->get(['id', 'customer_id', 'plan_id', 'starts_at']);

        $projectedOverageRevenue = 0;
        foreach ($activeSubscriptions as $subscription) {
            $plan = Plan::cached($subscription->plan_id);
            $used = (int) DB::table('daily_usage')
                ->where('customer_id', $subscription->customer_id)
                ->whereBetween('usage_date', [$start, $end])
                ->sum('units');

            $projectedOverageRevenue += max(0, $used - (int) $plan->included_units) * (float) $plan->overage_rate;
        }

        $thisMonth = DB::table('daily_usage')->select('customer_id', DB::raw('SUM(units) units'))
            ->whereBetween('usage_date', [$start, $end])
            ->groupBy('customer_id')
            ->pluck('units', 'customer_id');

        $lastMonth = DB::table('daily_usage')->select('customer_id', DB::raw('SUM(units) units'))
            ->whereBetween('usage_date', [$previousStart, $previousEnd])
            ->groupBy('customer_id')
            ->pluck('units', 'customer_id');

        $churnRisk = [];
        foreach ($lastMonth as $customerId => $oldUnits) {
            if ($oldUnits <= 0) {
                continue;
            }

            $newUnits = (int) ($thisMonth[$customerId] ?? 0);
            if ($newUnits < ($oldUnits * 0.5)) {
                $customer = Customer::find($customerId, ['id', 'name', 'email']);
                if ($customer) {
                    $churnRisk[] = [
                        'customer' => $customer,
                        'last_month_units' => (int) $oldUnits,
                        'this_month_units' => $newUnits,
                    ];
                }
            }
        }

        return [
            'merchant' => $merchant->only(['id', 'name']),
            'cycle_start' => $start,
            'cycle_end' => $end,
            'top_5_customers_by_usage_this_month' => $topCustomers,
            'projected_overage_revenue_current_cycle' => round($projectedOverageRevenue, 2),
            'usage_drop_over_50_percent_month_over_month' => $churnRisk,
        ];
    }
}
