<?php

namespace Database\Factories;

use App\Models\Invoice;
use App\Models\Subscription;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Invoice>
 */
class InvoiceFactory extends Factory
{
    protected $model = Invoice::class;

    public function definition(): array
    {
        return [
            'subscription_id' => Subscription::factory(),
            'period_start' => fake()->date(),
            'period_end' => fake()->date(),
            'base_amount' => fake()->randomFloat(2, 10, 500),
            'included_units' => fake()->numberBetween(100, 10000),
            'used_units' => fake()->numberBetween(0, 20000),
            'overage_units' => fake()->numberBetween(0, 10000),
            'overage_amount' => fake()->randomFloat(2, 0, 500),
            'total_amount' => fake()->randomFloat(2, 10, 1000),
            'status' => 'final',
        ];
    }

    public function final(): static
    {
        return $this->state(fn (array $attributes) => ['status' => 'final']);
    }
}
