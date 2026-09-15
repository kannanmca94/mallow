<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class () extends Migration {
    public function up(): void
    {
        Schema::create('customers', function (Blueprint $t) {
            $t->id();
            $t->foreignId('merchant_id')->constrained()->cascadeOnDelete();
            $t->string('name');
            $t->string('email')->index();
            $t->timestamps();
            $t->index(['merchant_id','id']);
        });
    }
    public function down(): void
    {
        Schema::dropIfExists('customers');
    }
};
