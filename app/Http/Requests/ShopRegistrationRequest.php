<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ShopRegistrationRequest extends FormRequest
{
    public function authorize()
    {
        // Only owners can register shops
        return $this->user()->role === 'owner';
    }

    public function rules()
    {
        return [
            'name' => 'required|string|max:255',
            'image' => 'nullable|image|max:2048',
            'address' => 'required|string|max:500',
            'latitude' => 'required|numeric|between:-90,90',
            'longitude' => 'required|numeric|between:-180,180',

            // Workers is array of objects
            'workers' => 'required|array|min:1',
            'workers.*.name' => 'required|string|max:255',
            'workers.*.specialty' => 'nullable|string|max:255',
            'workers.*.profile_image' => 'nullable|image|max:2048',

            // Working hours array of 7 days expected
            'working_hours' => 'required|array|size:7',
            'working_hours.*.day_of_week' => 'required|integer|between:0,6',
            'working_hours.*.open_time' => 'required|date_format:H:i',
            'working_hours.*.close_time' => 'required|date_format:H:i|after:working_hours.*.open_time',
        ];
    }
}
