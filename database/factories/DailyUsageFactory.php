<?php

namespace Database\Factories;

use App\Models\Customer;
use App\Models\DailyUsage;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\DailyUsage>
 */
class DailyUsageFactory extends Factory
{
    protected $model = DailyUsage::class;

    public function definition(): array
    {
        return [
            'customer_id' => Customer::factory(),
            'usage_date' => fake()->date(),
            'units' => fake()->numberBetween(1, 10000),
        ];
    }
}
