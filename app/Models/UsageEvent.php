<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UsageEvent extends Model
{
    use HasFactory;
    protected $fillable = [
        'customer_id','usage_date','units','idempotency_key'
    ];

    protected $casts = ['units' => 'integer'];

    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }
}
