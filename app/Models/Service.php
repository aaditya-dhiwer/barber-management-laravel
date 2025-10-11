<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\ServiceCategory;
use App\Models\Shop;

class Service extends Model
{
    use HasFactory;
    protected $fillable = [
        'category_id',
        'name',
        'description',
        'price',
        'duration',
        'product_cost',
        'special_price',
        'is_active',
    ];
    protected $hidden = ['created_at', 'updated_at', "price", "product_cost", "special_price"];
    public function category()
    {
        return $this->belongsTo(ServiceCategory::class, 'category_id');
    }
    public function shop()
    {
        return $this->belongsTo(Shop::class);
    }
}
