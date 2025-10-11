<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\ServiceCategory;
use App\Models\Shop;

class ShopService extends Model
{
    use HasFactory;
    protected $hidden = ['created_at', 'updated_at'];
    public function category()
    {
        return $this->belongsTo(ServiceCategory::class, 'category_id');
    }
    public function shop()
    {
        return $this->belongsTo(Shop::class);
    }
}
