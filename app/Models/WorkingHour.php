<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class WorkingHour extends Model

{
    protected $fillable = ['shop_id', 'day_of_week', 'open_time', 'close_time'];

    public function shop()
    {
        return $this->belongsTo(Shop::class);
    }
}
