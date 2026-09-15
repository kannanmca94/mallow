<?php

namespace App\Http\Controllers;

use App\Jobs\AggregateDailyUsageJob;
use App\Models\Customer;
use App\Models\UsageEvent;
use Illuminate\Http\Request;

class UsageController extends Controller
{
    public function store(Request $request)
    {
        $data = $request->validate([
            'customer_id' => ['required','integer','exists:customers,id'],
            'usage_date' => ['required','date'],
            'units' => ['required','integer','min:1'],
            'idempotency_key' => ['required','string','max:120'],
        ]);

        $customer = Customer::findOrFail($data['customer_id']);

        $event = UsageEvent::firstOrCreate(
            ['idempotency_key' => $data['idempotency_key']],
            [
                'customer_id' => $customer->id,
                'usage_date' => $data['usage_date'],
                'units' => $data['units'],
            ]
        );

        AggregateDailyUsageJob::dispatch($data['usage_date']);

        return response()->json([
            'success' => true,
            'duplicate' => $event->wasRecentlyCreated === false,
            'data' => $event
        ], $event->wasRecentlyCreated ? 201 : 200);
    }
}
