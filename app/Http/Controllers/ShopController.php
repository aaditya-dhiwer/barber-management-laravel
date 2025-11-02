<?php

namespace App\Http\Controllers;

use App\Models\Shop;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\URL;

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
            // $data['current_step'] = '2';
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

    public function getCurrentShopStatus(Request $request)
    {
        try {
            $user = auth()->user();

            if (Gate::denies('isOwner')) {
                return response()->json(['message' => 'Unauthorized', "status" => false], 403);
            }
            $shop = Shop::where('owner_id', $user->id)->first();
            if (!$shop) {
                return response()->json(['message' => 'Shop not found', "status" => false], 404);
            }
            return response()->json(['message' => 'Shop found', "status" => true, "current_step" => $shop->current_step]);
        } catch (\Throwable $th) {
            $response = ['message' => 'Error occurred: ' . $th->getMessage(), "status" => false];
            return response()->json($response, 500);
        }
    }

    public function approvedShop(Request $request, $shopId)
    {
        try {
            $user = auth()->user();


            $shop = Shop::find($shopId);
            if (!$shop) {
                return response()->json(['message' => 'No approved shop found', "status" => false], 404);
            }
            $shop->status = 'approved';
            $shop->current_step = 5;
            $shop->is_active = true;
            $shop->save();
            return response()->json(['message' => 'Shop approved successfully', "status" => true, "shop" => $shop]);
        } catch (\Throwable $th) {
            $response = ['message' => 'Error occurred: ' . $th->getMessage(), "status" => false];
            return response()->json($response, 500);
        }
    }

    // public function getAllShopForUsers(Request $request)
    // {
    //     // try {
    //     //     $shops = Shop::where("is_active", true)->get();
    //     //     foreach ($shops as $shop) {
    //     //         if ($shop->profile_image) {
    //     //             $shop->profile_image = url(Storage::url($shop->profile_image));
    //     //         }
    //     //     }
    //     //     return response()->json(['message' => 'Shops retrieved successfully', "status" => true, "shops" => $shops]);
    //     // } catch (\Throwable $th) {
    //     //     $response = ['message' => 'Error occurred: ' . $th->getMessage(), "status" => false];
    //     //     return response()->json($response, 500);
    //     // }
    //     {
    //         try {
    //             $shops = Shop::where('is_active', true)
    //                 ->with(['services.category'])
    //                 ->get();

    //             $responseShops = $shops->map(function ($shop) {
    //                 // Full image URL
    //                 $image = $shop->profile_image ? url(Storage::url($shop->profile_image)) : null;

    //                 // Group services by gender and category
    //                 $groupedServices = [
    //                     'male' => [],
    //                     'female' => []
    //                 ];

    //                 $services = $shop->services->groupBy(['gender', fn($item) => $item->category->name ?? 'Uncategorized']);

    //                 foreach ($services as $gender => $categories) {
    //                     foreach ($categories as $categoryName => $items) {
    //                         $groupedServices[$gender][] = [
    //                             'category' => $categoryName,
    //                             'items' => $items->map(function ($service) {
    //                                 return [
    //                                     'id' => $service->id,
    //                                     'name' => $service->name,
    //                                     'price' => $service->price,
    //                                     'duration' => $service->duration,
    //                                     'description' => $service->description,
    //                                 ];
    //                             })->values()
    //                         ];
    //                     }
    //                 }

    //                 return [
    //                     'id' => $shop->id,
    //                     'name' => $shop->name,
    //                     'profile_image' => $image,
    //                     'address' => $shop->address,
    //                     'city' => $shop->city,
    //                     'phone' => $shop->phone,
    //                     'open' => $shop->open,
    //                     'close' => $shop->close,
    //                     'services' => $groupedServices,
    //                 ];
    //             });

    //             return response()->json([
    //                 'message' => 'Shops retrieved successfully',
    //                 'status' => true,
    //                 'shops' => $responseShops,
    //             ]);
    //         } catch (\Throwable $th) {
    //             return response()->json([
    //                 'message' => 'Error occurred: ' . $th->getMessage(),
    //                 'status' => false,
    //             ], 500);
    //         }
    //     }
    // }


    // public function getAllShopForUsers(Request $request)
    // {
    //     try {

    //         $shops = Shop::with(['services.category'])

    //             ->get();

    //         $formattedShops = [];

    //         foreach ($shops as $shop) {

    //             $imageUrl = $shop->profile_image
    //                 ? url(Storage::url($shop->profile_image))
    //                 : null;
    //             $shop->setAttribute('profile_image', $imageUrl);


    //             $groupedServices = [];
    //             foreach ($shop->services as $service) {
    //                 $categoryName = $service->category->name ?? 'Uncategorized';
    //                 $groupedServices[$categoryName][] = $service->toArray();
    //             }


    //             $shopArray = $shop->toArray();
    //             $shopArray['services_by_category'] = $groupedServices;

    //             $formattedShops[] = $shopArray;
    //         }

    //         return response()->json([
    //             'message' => 'Shops retrieved successfully',
    //             'status'  => true,
    //             'shops'   => $formattedShops,
    //         ]);
    //     } catch (\Throwable $th) {
    //         return response()->json([
    //             'message' => 'Error occurred: ' . $th->getMessage(),
    //             'status'  => false,
    //         ], 500);
    //     }
    // }
    public function getAllShopForUsers(Request $request)
    {
        try {
            // Eager load shops and their services with categories
            $shops = Shop::with(['services.category'])
                ->get();

            $formattedShops = [];

            foreach ($shops as $shop) {
                $groupedServices = [];
                $imagePath = $shop->profile_image;
                $shop['profile_image'] = $imagePath ? url(Storage::url($imagePath)) : null;

                foreach ($shop->services as $service) {
                    // Determine the category name
                    $categoryName = $service->category->name ?? 'Uncategorized';

                    // You can further group by gender here if needed, 
                    // but grouping by Category Name first is clearer for a Shop Page

                    $groupedServices[$categoryName][] = [
                        'id'          => $service->id,
                        'name'        => $service->name,
                        'description' => $service->description,
                        'price'       => $service->price,
                        'gender'      => $service->gender,
                        'duration'      => $service->duration,
                        'product_cost'      => $service->product_cost,
                        "special_price" => $service->special_price,

                    ];
                }

                // 3. Prepare the s  hop array: The crucial steps

                // a. Hides the original 'services' relationship to avoid duplication.
                $shop->makeHidden(['services']);

                // b. Convert the shop model to an array (now without the original services)
                $shopArray = $shop->toArray();

                // c. Remove the old profile_image path if you prefer the new URL to be the only one
                // unset($shopArray['profile_image']);

                // d. Add the custom grouped services
                $shopArray['services_by_category'] = $groupedServices;

                $formattedShops[] = $shopArray;
            }

            return response()->json([
                'message' => 'Shops retrieved successfully',
                'status'  => true,
                'shops'   => $formattedShops,
            ]);
        } catch (\Throwable $th) {
            return response()->json([
                'message' => 'Error occurred: ' . $th->getMessage(),
                'status'  => false,
            ], 500);
        }
    }
}
