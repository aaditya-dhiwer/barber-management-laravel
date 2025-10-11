<?php

namespace App\Http\Controllers;

use App\Models\Shop;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Storage;

class ShopController extends Controller
{
    // List all shops owned by the authenticated owner
    public function index()
    {
        try {
            $user = auth()->user();

            if (Gate::denies('isOwner')) {
                return response()->json(['message' => 'Unauthorized'], 403);
            }

            $shops = Shop::where('owner_id', $user->id)->get();

            return response()->json($shops);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Error occurred: ' . $e->getMessage()], 500);
        }
    }

    // // Store a new shop
    // public function store(Request $request)
    // {
    //     try {

    //         $user = auth()->user();

    //         if (Gate::denies('isOwner')) {
    //             return response()->json(['message' => 'Unauthorized', "status" => false], 403);
    //         }

    //         $request->validate([
    //             'name' => 'required|string|max:255',
    //             'address' => 'required|string|max:500',
    //             'latitude' => 'required|numeric|between:-90,90',
    //             'longitude' => 'required|numeric|between:-180,180',
    //             'profile_image' => 'nullable|image|max:2048',
    //             'phone' => 'required|string|max:15',
    //             'open' => 'required|date_format:H:i',
    //             'close' => 'required|date_format:H:i|after:open',
    //             'description' => 'nullable|string|max:1000',
    //             'city' => 'nullable|string|max:100',
    //             'state' => 'nullable|string|max:100',
    //             'postal_code' => 'nullable|string|max:20',
    //         ]);

    //         $data = $request->only(['name', 'address', 'latitude', 'longitude', 'phone', 'open', 'close', 'description', 'city', 'state', 'postal_code']);
    //         $data['owner_id'] = $user->id;

    //         // return response()->json(["request" => $request->all()]);
    //         if ($request->hasFile('profile_image')) {
    //             $path = $request->file('profile_image')->store('shops', 'public');

    //             // echo();

    //             $data['profile_image'] = $path;
    //             // return response()->json(["path" => $path]);
    //         }

    //         $data['current_step'] = '1'; // Assuming step 1 is completed upon creation
    //         $shop = Shop::create($data);
    //         $shop->profile_image = url(Storage::url($shop->profile_image));
    //         $response = ["message" => "Shop created successfully", "shop" => $shop, "status" => true];

    //         return response()->json($response, 201);
    //     } catch (\Exception $e) {
    //         return response()->json(['message' => 'Error occurred: ' . $e->getMessage(), "status" => false], 500);
    //     }
    // }

    public function store(Request $request)
    {
        try {
            $user = auth()->user();
            if (Gate::denies('isOwner')) {
                return response()->json(['message' => 'Unauthorized', "status" => false], 403);
            }
            $request->validate([
                'name' => 'required|string|max:255',
                'address' => 'required|string|max:500',
                'latitude' => 'required|numeric|between:-90,90',
                'longitude' => 'required|numeric|between:-180,180',
                'profile_image' => 'nullable|image',
                'phone' => 'required|string|max:15',
                'open' => 'required|date_format:H:i',
                'close' => 'required|date_format:H:i|after:open',
                'description' => 'nullable|string|max:1000',
                'city' => 'nullable|string|max:100',
                'state' => 'nullable|string|max:100',
                'postal_code' => 'nullable|string|max:20',
            ]);
            $data = $request->only(['name', 'address', 'latitude', 'longitude', 'phone', 'open', 'close', 'description', 'city', 'state', 'postal_code']);
            $data['owner_id'] = $user->id;
            if ($request->hasFile('profile_image')) {
                $path = $request->file('profile_image')->store('shops', 'public');
                $data['profile_image'] = $path;
            }
            $data['current_step'] = '2';
            $shop = Shop::create($data);
            
            $shop->profile_image = url(Storage::url($shop->profile_image));
            $response = ["message" => "Shop created successfully", "shop" => $shop, "status" => true];
            return response()->json($response, 201);
        } catch (\Exception $e) {
            // fwrite(STDERR, "Debug: reached here, data=" . json_encode($e) . PHP_EOL);
            return response()->json(['message' => 'Error occurred: ' . $e->getMessage(), "status" => false], 500);
        }
    }

    // Show details of a specific shop owned by the authenticated owner
    public function show($id)
    {
        try {
            $user = auth()->user();

            $shop = Shop::findOrFail($id);

            if (Gate::denies('isOwner') || $shop->owner_id !== $user->id) {
                return response()->json(['message' => 'Unauthorized'], 403);
            }

            return response()->json($shop);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Error occurred: ' . $e->getMessage()], 500);
        }
    }

    // Update an existing shop
    public function update(Request $request, $id)
    {
        $user = auth()->user();

        $shop = Shop::findOrFail($id);

        if (Gate::denies('isOwner') || $shop->owner_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $request->validate([
            'name' => 'sometimes|required|string|max:255',
            'address' => 'sometimes|required|string|max:500',
            'latitude' => 'sometimes|required|numeric|between:-90,90',
            'longitude' => 'sometimes|required|numeric|between:-180,180',
            'image' => 'nullable|image|max:2048',
        ]);

        $shop->fill($request->only(['name', 'address', 'latitude', 'longitude']));

        if ($request->hasFile('image')) {
            // Delete old image if exists
            if ($shop->image) {
                Storage::disk('public')->delete($shop->image);
            }
            $path = $request->file('image')->store('shops', 'public');
            $shop->image = $path;
        }

        $shop->save();

        return response()->json($shop);
    }

    // Delete a shop and related entities (handled by foreign key cascade)
    public function destroy($id)
    {
        $user = auth()->user();

        $shop = Shop::findOrFail($id);

        if (Gate::denies('isOwner') || $shop->owner_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        if ($shop->image) {
            Storage::disk('public')->delete($shop->image);
        }

        $shop->delete();

        return response()->json(['message' => 'Shop deleted successfully']);
    }

    // For customers: get nearest shops (already provided, repeating here)
    public function nearest(Request $request)
    {
        $request->validate([
            'latitude' => 'required|numeric|between:-90,90',
            'longitude' => 'required|numeric|between:-180,180',
            'radius' => 'nullable|numeric|min:0',
        ]);

        $latitude = $request->latitude;
        $longitude = $request->longitude;
        $radius = $request->radius ?? 10; // default 10 km

        // Haversine formula to calculate distance in km
        $shops = Shop::selectRaw("*, ( 6371 * acos( cos( radians(?) ) * cos( radians(latitude) ) * cos( radians(longitude) - radians(?) ) + sin( radians(?) ) * sin( radians(latitude) ) ) ) AS distance", [$latitude, $longitude, $latitude])
            ->having('distance', '<=', $radius)
            ->orderBy('distance', 'asc')
            ->get();

        return response()->json($shops);
    }
}
