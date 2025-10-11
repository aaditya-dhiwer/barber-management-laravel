<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, Notifiable;

    protected $fillable = ['name', 'email', 'password', 'role'];

    protected $hidden = ['password', 'remember_token', 'created_at', 'updated_at'];

    public function shops()
    {
        return $this->hasMany(Shop::class, 'owner_id');
    }

    public function bookings()
    {
        return $this->hasMany(Booking::class, 'customer_id');
    }
}
