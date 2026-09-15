<?php

namespace App\Http\Controllers;

use App\Models\Subscription;
use App\Services\InvoiceService;
use Carbon\Carbon;
use Illuminate\Http\Request;

class InvoiceController extends Controller
{
    public function store(Request $request, Subscription $subscription, InvoiceService $service)
    {
        $data = $request->validate([
            'period_start' => ['required','date'],
            'period_end' => ['required','date','after_or_equal:period_start'],
        ]);

        $invoice = $service->generate(
            $subscription,
            Carbon::parse($data['period_start']),
            Carbon::parse($data['period_end'])
        );

        return response()->json(['success' => true,'invoice' => $invoice]);
    }
}
