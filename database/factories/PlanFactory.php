<?php

namespace Database\Factories;

use App\Models\Merchant;
use App\Models\Plan;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Plan>
 */
class PlanFactory extends Factory
{
    protected $model = Plan::class;

    public function definition(): array
    {
        return [
            'merchant_id' => Merchant::factory(),
            'name' => fake()->word(),
            'base_price' => fake()->randomFloat(2, 10, 500),
            'billing_cycle' => 'monthly',
            'included_units' => fake()->randomElement([1000, 5000, 10000, 50000]),
            'overage_rate' => fake()->randomFloat(4, 0.01, 0.50),
        ];
    }

    public function monthly(): static
    {
        return $this->state(fn (array $attributes) => ['billing_cycle' => 'monthly']);
    }

    public function yearly(): static
    {
        return $this->state(fn (array $attributes) => ['billing_cycle' => 'yearly']);
    }
}
