<?php

namespace Database\Factories;

use App\Models\Plan;
use App\Models\Subscription;
use App\Models\SubscriptionSegment;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\SubscriptionSegment>
 */
class SubscriptionSegmentFactory extends Factory
{
    protected $model = SubscriptionSegment::class;

    public function definition(): array
    {
        return [
            'subscription_id' => Subscription::factory(),
            'plan_id' => Plan::factory(),
            'effective_from' => now()->startOfMonth(),
            'effective_to' => null,
        ];
    }
}
