<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Booking;;

use App\Models\ShopService;

class BookingDetail extends Model
{
    use HasFactory;
    protected $fillable = [
        'booking_id',
        'service_id',
        'price_at_booking',
        'duration_minutes',
        'service_order',
    ];
    public function booking()
    {
        return $this->belongsTo(Booking::class);
    }

    public function service()
    {
        return $this->belongsTo(ShopService::class, 'service_id');
    }
}
