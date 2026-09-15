<?php

namespace App\Http\Controllers;

use App\Models\Merchant;
use App\Services\DashboardMetricsService;

class DashboardController extends Controller
{
    public function show(Merchant $merchant, DashboardMetricsService $metrics)
    {
        return response()->json($metrics->forMerchant($merchant));
    }
}
