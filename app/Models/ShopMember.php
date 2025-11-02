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
        'dob',
        'receive_sms_promotions',
        'receive_email_promotions',
        'is_active'
    ];
    protected $hidden = [
        'created_at',
        'updated_at',
        "receive_sms_promotions",
        "receive_email_promotions",
    ];
    protected $casts = [
        'receive_sms_promotions' => 'boolean',
        'receive_email_promotions' => 'boolean',
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
