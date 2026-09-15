<?php

namespace Database\Factories;

use App\Models\Customer;
use App\Models\Plan;
use App\Models\Subscription;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Subscription>
 */
class SubscriptionFactory extends Factory
{
    protected $model = Subscription::class;

    public function definition(): array
    {
        return [
            'customer_id' => Customer::factory(),
            'plan_id' => Plan::factory(),
            'starts_at' => now()->startOfMonth(),
            'ends_at' => null,
            'status' => 'active',
        ];
    }

    public function startsMidCycle(): static
    {
        return $this->state(fn (array $attributes) => [
            'starts_at' => now()->startOfMonth()->addDays(14),
        ]);
    }

    public function cancelled(): static
    {
        return $this->state(fn (array $attributes) => [
            'status' => 'cancelled',
            'ends_at' => now()->startOfMonth()->addDays(14),
        ]);
    }
}
