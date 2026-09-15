<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class () extends Migration {
    public function up(): void
    {
        Schema::create('subscriptions', function (Blueprint $t) {
            $t->id();
            $t->foreignId('customer_id')->constrained()->cascadeOnDelete();
            $t->foreignId('plan_id')->constrained();
            $t->dateTime('starts_at');
            $t->dateTime('ends_at')->nullable();
            $t->string('status', 20)->default('active');
            $t->timestamps();
            $t->index(['customer_id','status']);
            $t->index(['plan_id','starts_at']);
        });
    }
    public function down(): void
    {
        Schema::dropIfExists('subscriptions');
    }
};
