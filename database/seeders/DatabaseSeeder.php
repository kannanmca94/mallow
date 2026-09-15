<?php

namespace Database\Seeders;

use App\Models\Customer;
use App\Models\DailyUsage;
use App\Models\Merchant;
use App\Models\Plan;
use App\Models\Subscription;
use App\Models\SubscriptionSegment;
use App\Models\UsageEvent;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $merchant = Merchant::create(['name' => 'Demo Merchant']);

        $starter = Plan::create([
            'merchant_id' => $merchant->id,
            'name' => 'Starter',
            'base_price' => 100,
            'billing_cycle' => 'monthly',
            'included_units' => 1000,
            'overage_rate' => 0.10,
        ]);
        $pro = Plan::create([
            'merchant_id' => $merchant->id,
            'name' => 'Pro',
            'base_price' => 250,
            'billing_cycle' => 'monthly',
            'included_units' => 5000,
            'overage_rate' => 0.07,
        ]);

        // Fixed daily usage patterns (12 days of the current month) so the
        // dashboard always shows the same demo data across re-seeds.
        // Customer 4 and 8 have high usage → show overage on the Starter/Pro plans.
        $thisMonthPatterns = [
            1 => [820, 910, 750, 680, 430, 310, 870, 940, 220, 760, 890, 650],
            2 => [300, 410, 280, 350, 190, 420, 310, 380, 270, 340, 300, 260],
            3 => [600, 550, 720, 680, 490, 380, 510, 430, 620, 700, 580, 470],
            4 => [950, 880, 770, 920, 610, 530, 840, 910, 730, 870, 960, 800],
            5 => [120, 90, 150, 80, 200, 110, 160, 70, 130, 180, 100, 140],
            6 => [1800, 2100, 1950, 2300, 1700, 2050, 2400, 2200, 1850, 2150, 2350, 2000],
            7 => [400, 350, 480, 520, 310, 290, 410, 380, 350, 460, 390, 340],
            8 => [2500, 2800, 2200, 3100, 1900, 2600, 2750, 3000, 2400, 2900, 3200, 2550],
        ];

        foreach ($thisMonthPatterns as $custIdx => $dailyUnits) {
            $customer = Customer::create([
                'merchant_id' => $merchant->id,
                'name' => "Customer $custIdx",
                'email' => "customer{$custIdx}@example.com",
            ]);

            $plan = $custIdx > 5 ? $pro : $starter;
            $subscription = Subscription::create([
                'customer_id' => $customer->id,
                'plan_id' => $plan->id,
                'starts_at' => now()->startOfMonth(),
                'status' => 'active',
            ]);

            SubscriptionSegment::create([
                'subscription_id' => $subscription->id,
                'plan_id' => $plan->id,
                'effective_from' => $subscription->starts_at,
                'effective_to' => null,
            ]);

            $monthTotal = 0;
            foreach ($dailyUnits as $dayIndex => $units) {
                $monthTotal += $units;
                $date = now()->startOfMonth()->addDays($dayIndex)->toDateString();

                UsageEvent::create([
                    'customer_id' => $customer->id,
                    'usage_date' => $date,
                    'units' => $units,
                    'idempotency_key' => Str::uuid()->toString(),
                ]);

                DailyUsage::create([
                    'customer_id' => $customer->id,
                    'usage_date' => $date,
                    'units' => $units,
                ]);
            }
        }

        // ── Churn-risk demo ────────────────────────────────────────────
        // Customer 5 used 3,200 units LAST month (20 days x 160) but only
        // ~1,530 so far this month (< 50 % of last month) → flagged as
        // at risk of churn.
        $churnCustomer = Customer::where('email', 'customer5@example.com')->first();
        if ($churnCustomer) {
            $lastMonthStart = now()->subMonth()->startOfMonth();
            foreach (range(0, 19) as $d) {
                DB::table('daily_usage')->insert([
                    'customer_id' => $churnCustomer->id,
                    'usage_date' => $lastMonthStart->copy()->addDays($d)->toDateString(),
                    'units' => 160,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
    }
}
