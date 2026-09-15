<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class () extends Migration {
    public function up(): void
    {
        Schema::create('subscription_segments', function (Blueprint $t) {
            $t->id();
            $t->foreignId('subscription_id')->constrained()->cascadeOnDelete();
            $t->foreignId('plan_id')->constrained();
            $t->dateTime('effective_from');
            $t->dateTime('effective_to')->nullable();
            $t->timestamps();
            $t->index(['subscription_id','effective_from']);
            $t->index(['plan_id','effective_from']);
        });
    }
    public function down(): void
    {
        Schema::dropIfExists('subscription_segments');
    }
};
