<?php

namespace App\Http\Controllers;

use App\Models\Merchant;
use App\Services\DashboardMetricsService;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    public function index(Request $request, DashboardMetricsService $metrics)
    {
        $merchants = Merchant::orderBy('id')->get(['id', 'name']);

        /** @var Merchant|null $merchant */
        $merchant = $merchants->firstWhere('id', $request->integer('merchant'))
            ?? $merchants->first();

        if (! $merchant) {
            return view('dashboard')->with('empty', true);
        }

        return view('dashboard')->with([
            'metrics' => $metrics->forMerchant($merchant),
            'merchants' => $merchants,
            'merchant' => $merchant,
        ]);
    }
}
