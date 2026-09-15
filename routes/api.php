<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UsageController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\InvoiceController;

Route::post('/usage', [UsageController::class, 'store'])
    ->middleware('throttle:ingestion');

Route::get('/merchants/{merchant}/dashboard', [DashboardController::class, 'show']);

Route::post('/subscriptions/{subscription}/invoice', [InvoiceController::class, 'store']);
