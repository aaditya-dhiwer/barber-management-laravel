<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\Storage;

class ShopResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $groupedServices = $this->whenLoaded('services', function () {
            return $this->services->groupBy(function ($service) {
                return $service->category->name ?? 'Uncategorized';
            })->map(function ($services) {
                // Use the ServiceResource to format the services within each group
                return ServiceResource::collection($services);
            });
        });

        // Get the profile image URL
        $imageUrl = $this->profile_image
            ? url(Storage::url($this->profile_image))
            : null;

        return [
            'id'                  => $this->id,
            'name'                => $this->name,
            'address'             => $this->address,
            'profile_image_url'   => $imageUrl,
            // ... other shop fields

            // The one and only place for service data
            'services_by_category' => $groupedServices,

            // This ensures the default, unformatted 'services' relation is NOT included
            // You can remove this if 'services' is not an attribute on the Shop model
            $this->mergeWhen(false, ['services' => null]),
        ];
    }
}
