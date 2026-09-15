<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class () extends Migration {
    public function up(): void
    {
        Schema::create('daily_usage', function (Blueprint $t) {
            $t->id();
            $t->foreignId('customer_id')->constrained()->cascadeOnDelete();
            $t->date('usage_date');
            $t->unsignedBigInteger('units')->default(0);
            $t->timestamps();
            $t->unique(['customer_id','usage_date']);
        });
    }
    public function down(): void
    {
        Schema::dropIfExists('daily_usage');
    }
};
