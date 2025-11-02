<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;
use Illuminate\Database\Eloquent\Casts\Attribute;

class Shop extends Model
{
    protected $fillable = ['owner_id', 'name', "current_step", 'profile_image', 'address', 'latitude', 'longitude', "phone", "open", "close", "is_active", "description", "status", "city", "state", "postal_code"];
    protected $hidden = ['created_at', 'updated_at', "current_step", "status"];
    public function owner()
    {
        return $this->belongsTo(User::class, 'owner_id');
    }

    public function services()
    {
        return $this->hasMany(ShopService::class);
    }
    public function members()
    {
        return $this->hasMany(ShopMember::class);
    }

    public function bookings()
    {
        return $this->hasMany(Booking::class);
    }


    public function workingHours()
    {
        return $this->hasMany(WorkingHour::class);
    }

    public function images()
    {
        return $this->hasMany(ShopImage::class);
    }

    public function getProfileImageUrlAttribute()
    {
        return $this->profile_image ? Storage::url($this->profile_image) : null;
    }

    public function getImagesUrlsAttribute()
    {
        return $this->images->map(function ($image) {
            return Storage::url($image->image_path);
        });
    }

    // protected $appends = ['profile_image_url']; // optional if you want extra field

    // 👇 Accessor for full URL
    // protected function profileImage(): Attribute
    // {
    //     return Attribute::make(
    //         get: fn($value) => $value
    //             ? asset('storage/' . $value)
    //             : asset('images/default_shop.png') // fallback if null
    //     );
    // return Attribute::make(
    //     get: fn($value) => $value
    //         ? asset('storage/' . $value)
    //         : asset('images/default_shop.png') // fallback if null
    // );
    // }
}
