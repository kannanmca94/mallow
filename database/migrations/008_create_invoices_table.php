<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class () extends Migration {
    public function up(): void
    {
        Schema::create('invoices', function (Blueprint $t) {
            $t->id();
            $t->foreignId('subscription_id')->constrained()->cascadeOnDelete();
            $t->date('period_start');
            $t->date('period_end');
            $t->decimal('base_amount', 12, 2)->default(0);
            $t->unsignedBigInteger('included_units')->default(0);
            $t->unsignedBigInteger('used_units')->default(0);
            $t->unsignedBigInteger('overage_units')->default(0);
            $t->decimal('overage_amount', 12, 2)->default(0);
            $t->decimal('total_amount', 12, 2)->default(0);
            $t->string('status', 20)->default('final');
            $t->timestamps();
            $t->unique(['subscription_id','period_start','period_end']);
        });
    }
    public function down(): void
    {
        Schema::dropIfExists('invoices');
    }
};
