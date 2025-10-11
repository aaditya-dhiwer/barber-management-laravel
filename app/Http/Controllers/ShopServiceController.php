<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Shop;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\JsonResponse;
use App\Models\ServiceCategory;
use App\Models\ShopService;

class ShopServiceController extends Controller
{
    public function index()
    {
        try {
            $user = auth()->user();
            $services = ShopService::all();

            return response()->json(['message' => 'Services retrieved successfully', "status" => true, 'services' => $services], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => 'Error occurred: ' . $th->getMessage(), "status" => false], 500);
        }
    }
    public function store(Request $request)

    {
        try {
            DB::beginTransaction();
            $user = auth()->user();

            if ($user->role !== 'owner') {
                return response()->json(['message' => 'Unauthorized', "status" => false], 403);
            }

            // Validate the request

            $validator = Validator::make($request->all(), [
                'services' => 'required|array|min:1',
                'services.*.name' => 'required|string|max:255',
                'services.*.duration' => 'required|integer|min:1',
                'services.*.price' => 'required|numeric|min:0',
                'services.*.product_cost' => 'nullable|numeric|min:0',
                'services.*.special_price' => 'nullable|numeric|min:0',
                'services.*.description' => 'nullable|string',
                'services.*.category_id' => 'required|exists:service_categories,id',
            ]);
            if ($validator->fails()) {
                return response()->json(['error' => 'Validation Error', 'messages' => $validator->errors(), "status" => false], 422);
            }
            // foreach ($request->services as $serviceData) {
            //     $service = new ShopService();
            //     $service->name = $serviceData['name'];
            //     $service->description = $serviceData['description'] ?? null;
            //     $service->price = $serviceData['price'];
            //     $service->duration = $serviceData['duration'];
            //     $service->category_id = $serviceData['category_id'];
            //     $service->product_cost = $serviceData['product_cost'] ?? null;
            //     $service->special_price = $serviceData['special_price'] ?? null;

            //     $service->save();

            //     $createdServices[] = $service;
            // }

            // Check if the shop belongs to the authenticated owner
            $shop = Shop::where('owner_id', $user->id)
                ->first();

            if (!$shop) {
                return response()->json(['message' => 'Shop not found or unauthorized', "status" => false], 404);
            }

            // Create the services
            $createdServices = [];
            foreach ($request->services as $serviceData) {
                $service = new ShopService();
                $service->name = $serviceData['name'];
                $service->description = $serviceData['description'] ?? null;
                $service->price = $serviceData['price'];
                $service->duration = $serviceData['duration'];
                $service->category_id = $serviceData['category_id'];
                $service->product_cost = $serviceData['product_cost'] ?? null;
                $service->special_price = $serviceData['special_price'] ?? null;
                $service->shop_id = $shop->id;
                $service->is_active = $serviceData['is_active'] ?? true;
                $service->gender = $serviceData['gender'] ?? null;
                $service->save();

                $createdServices[] = $service;
            }

            // After service successfully created changed the current_step of shop to 2
            // Update current_step only if not already completed
            if ($shop->current_step < 5) {
                $shop->current_step = 4;
                $shop->save();
            }
            DB::commit();


            return response()->json(['message' => 'Services created successfully', "status" => true, "data-length" => count($createdServices), 'services' => $createdServices,], 201);
        } catch (\Throwable $th) {
            DB::rollBack();
            return response()->json(['message' => 'Error occurred: ' . $th->getMessage(), "status" => false], 500);
        }
    }
}
