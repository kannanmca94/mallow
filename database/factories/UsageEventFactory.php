<?php

namespace Database\Factories;

use App\Models\Customer;
use App\Models\UsageEvent;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\UsageEvent>
 */
class UsageEventFactory extends Factory
{
    protected $model = UsageEvent::class;

    public function definition(): array
    {
        return [
            'customer_id' => Customer::factory(),
            'usage_date' => fake()->date(),
            'units' => fake()->numberBetween(1, 1000),
            'idempotency_key' => fake()->unique()->uuid(),
        ];
    }
}
