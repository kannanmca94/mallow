<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class () extends Migration {
    public function up(): void
    {
        Schema::create('usage_events', function (Blueprint $t) {
            $t->id();
            $t->foreignId('customer_id')->constrained()->cascadeOnDelete();
            $t->date('usage_date');
            $t->unsignedBigInteger('units');
            $t->string('idempotency_key', 120)->unique();
            $t->timestamps();
            $t->index(['customer_id','usage_date']);
            $t->index(['usage_date','customer_id']);
        });
    }
    public function down(): void
    {
        Schema::dropIfExists('usage_events');
    }
};
