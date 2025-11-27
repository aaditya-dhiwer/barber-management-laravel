<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Carbon;

class PendingVerification extends Model
{
    use HasFactory;
    protected $fillable = ['name', 'email', 'password', 'otp', 'expires_at', 'role'];

    public function isExpired()
    {
        return Carbon::now()->gt($this->expires_at);
    }
}
