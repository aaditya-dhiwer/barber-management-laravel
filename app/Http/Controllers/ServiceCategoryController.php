<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ServiceCategory;
use Illuminate\Support\Facades\Validator;

class ServiceCategoryController extends Controller
{

    public function index()
    {
        // List all service categories
        try {
            $categories = ServiceCategory::where('is_active', true)->get();
            $response = [
                'status' => true,
                'data' => $categories
            ];
            return response()->json($response, 200);
        } catch (\Throwable $th) {
            return response()->json(['error' => 'Failed to retrieve service categories', 'message' => $th->getMessage(), "status" => false], 500);
        }
    }

    public function store(Request $request)
    {
        // Create a new service category
        try {
            $validator = Validator::make($request->all(), [
                'name' => 'required|string|max:255',
                'description' => 'nullable|string|max:500',
                'gender' => 'required|in:male,female,other',
            ]);
            if ($validator->fails()) {
                return response()->json(['error' => 'Validation Error', 'messages' => $validator->errors(), "status" => false], 422);
            }


            $category = ServiceCategory::create([
                'name' => $request->name,
                'description' => $request->description,
                'is_active' => true,
            ]);

            return response()->json(['message' => 'Service category created successfully', 'data' => $category, "status" => true], 201);
        } catch (\Throwable $th) {
            return response()->json(['error' => 'Failed to create service category', 'message' => $th->getMessage(), "status" => false], 500);
        }
    }
}
