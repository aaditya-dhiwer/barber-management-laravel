<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Http\Requests\ShopRegistrationRequest;
use App\Models\Shop;
use App\Models\ShopMember;
use App\Models\WorkingHour;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class ShopRegistrationController extends Controller
{
    public function register(ShopRegistrationRequest $request)
    {
        $user = $request->user();

        DB::beginTransaction();

        try {
            // Upload shop image if exists
            $shopImagePath = null;
            if ($request->hasFile('image')) {
                $shopImagePath = $request->file('image')->store('shops', 'public');
            }

            // Create shop
            $shop = Shop::create([
                'owner_id' => $user->id,
                'name' => $request->name,
                'image' => $shopImagePath,
                'address' => $request->address,
                'latitude' => $request->latitude,
                'longitude' => $request->longitude,
            ]);

            // Create workers
            foreach ($request->workers as $workerData) {
                $profileImagePath = null;
                if (isset($workerData['profile_image']) && is_a($workerData['profile_image'], \Illuminate\Http\UploadedFile::class)) {
                    $profileImagePath = $workerData['profile_image']->store('shop_members', 'public');
                }
                ShopMember::create([
                    'shop_id' => $shop->id,
                    'name' => $workerData['name'],
                    'specialty' => $workerData['specialty'] ?? null,
                    'profile_image' => $profileImagePath,
                ]);
            }

            // Create working hours
            foreach ($request->working_hours as $wh) {
                WorkingHour::create([
                    'shop_id' => $shop->id,
                    'day_of_week' => $wh['day_of_week'],
                    'open_time' => $wh['open_time'],
                    'close_time' => $wh['close_time'],
                ]);
            }

            DB::commit();

            return response()->json([
                'message' => 'Shop registered successfully',
                'shop' => $shop->load('members', 'workingHours'),
            ], 201);
        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                'message' => 'Failed to register shop',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
