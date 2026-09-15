<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class () extends Migration {
    public function up(): void
    {
        Schema::create('plans', function (Blueprint $t) {
            $t->id();
            $t->foreignId('merchant_id')->constrained()->cascadeOnDelete();
            $t->string('name');
            $t->decimal('base_price', 12, 2);
            $t->string('billing_cycle', 20)->default('monthly');
            $t->unsignedBigInteger('included_units')->default(0);
            $t->decimal('overage_rate', 12, 4)->default(0);
            $t->timestamps();
            $t->index(['merchant_id','billing_cycle']);
        });
    }
    public function down(): void
    {
        Schema::dropIfExists('plans');
    }
};
