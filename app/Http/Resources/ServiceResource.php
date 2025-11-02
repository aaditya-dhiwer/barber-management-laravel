<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ServiceResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id'          => $this->id,
            'name'        => $this->name,
            'description' => $this->description,
            'price'       => $this->price,
            'gender'      => $this->gender,
            // You can optionally include category here if you need it outside of the grouping
            // 'category_name' => $this->whenLoaded('category', fn() => $this->category->name ?? 'Uncategorized'),
        ];
    }
}
