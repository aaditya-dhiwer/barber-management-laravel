<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Service;

class ServiceCategory extends Model
{
    use HasFactory;
    protected $fillable = [
        'name',
        'description',
        'gender',
        'is_active',
    ];

    // public function services()
    // {
    //     return $this->hasMany(Service::class, 'category_id');
    // }
    public function services()
    {
        
        return $this->hasMany(Service::class, 'category_id')
            ->where('is_active', true)
           
            ->select([
                'id',
                'category_id',
                'name',
                'description',
                'price',
                'duration',
                'product_cost',
                'special_price'
            ]);
    }
}
