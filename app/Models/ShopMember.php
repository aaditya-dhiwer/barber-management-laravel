<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ShopMember extends Model
{
    protected $fillable = [
        'shop_id',
        'name',
        'profile_image',
        'specialty',
        "phone",
        "bio",
        'role',
        'is_active'
    ];

    public function shop()
    {
        return $this->belongsTo(Shop::class);
    }

    public function bookings()
    {
        return $this->hasMany(Booking::class);
    }
}
