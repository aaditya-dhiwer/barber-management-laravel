<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Booking extends Model
{
    protected $fillable = [
        'shop_id',
        "shop_member_id",
        'customer_id',
        "date",
        'start_time',
        'end_calculated_time',
        'total_duration',
        'total_price',
        'status',
        'notes',
    ];
    protected $casts = [
        'start_time' => 'datetime',
        'end_time_calculated' => 'datetime',
    ];


    public function shop()
    {
        return $this->belongsTo(Shop::class);
    }
    public function details()
    {
        return $this->hasMany(BookingDetail::class, 'booking_id');
    }

    public function shopMember()
    {
        return $this->belongsTo(ShopMember::class);
    }

    public function customer()
    {
        return $this->belongsTo(User::class, 'customer_id');
    }

    public function staff()
    {
        return $this->belongsTo(ShopMember::class, 'shop_member_id');
    }
}
