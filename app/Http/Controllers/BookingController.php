<?php
// app/Http/Controllers/BookingController.php

namespace App\Http\Controllers;

use App\Models\Booking;
use Carbon\Carbon;
use App\Models\Shop;
use App\Models\ShopMember;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

use App\Models\ShopService;
use PhpParser\Node\Expr\FuncCall;

class BookingController extends Controller
{
    // For Owner: list bookings for a shop
    // public function index(Request $request, $shopId = null)
    // {
    //     $user = auth()->user();

    //     if ($user->role === 'owner') {
    //         $shop = Shop::findOrFail($shopId);

    //         if ($shop->owner_id !== $user->id) {
    //             return response()->json(['message' => 'Unauthorized'], 403);
    //         }
    //         $bookings = $shop->bookings()->with(['customer', 'shopMember'])->get();
    //         return response()->json($bookings);
    //     }

    //     if ($user->role === 'customer') {
    //         $bookings = Booking::where('customer_id', $user->id)->with(['shop', 'shopMember'])->get();
    //         return response()->json($bookings);
    //     }

    //     return response()->json(['message' => 'Unauthorized'], 403);
    // }

    // // For Customer: create booking
    // public function store(Request $request)
    // {
    //     $user = auth()->user();

    //     if ($user->role !== 'customer') {
    //         return response()->json(['message' => 'Only customers can create bookings'], 403);
    //     }

    //     $request->validate([
    //         'shop_id' => 'required|exists:shops,id',
    //         'shop_member_id' => 'nullable|exists:shop_members,id',
    //         'date' => 'required|date|after_or_equal:today',
    //         'time' => 'required|date_format:H:i',
    //     ]);

    //     $shop = Shop::findOrFail($request->shop_id);

    //     if ($request->shop_member_id) {
    //         $member = ShopMember::where('shop_id', $shop->id)->findOrFail($request->shop_member_id);
    //     }

    //     $booking = Booking::create([
    //         'shop_id' => $shop->id,
    //         'shop_member_id' => $request->shop_member_id,
    //         'customer_id' => $user->id,
    //         'date' => $request->date,
    //         'time' => $request->time,
    //         'status' => 'pending',
    //     ]);

    //     return response()->json($booking, 201);
    // }

    // For Owner: update booking status
    // public function update(Request $request, $shopId, $bookingId)
    // {
    //     $user = auth()->user();

    //     if ($user->role !== 'owner') {
    //         return response()->json(['message' => 'Only owners can update bookings'], 403);
    //     }

    //     $shop = Shop::findOrFail($shopId);

    //     if ($shop->owner_id !== $user->id) {
    //         return response()->json(['message' => 'Unauthorized'], 403);
    //     }

    //     $booking = Booking::where('shop_id', $shop->id)->findOrFail($bookingId);

    //     $request->validate([
    //         'status' => 'required|in:pending,confirmed,cancelled',
    //     ]);

    //     $booking->status = $request->status;
    //     $booking->save();

    //     return response()->json($booking);
    // }

    // For Owner or Customer: show booking details
    // public function show(Request $request, $shopId = null, $bookingId)
    // {
    //     $user = auth()->user();

    //     if ($user->role === 'owner') {
    //         $shop = Shop::findOrFail($shopId);

    //         if ($shop->owner_id !== $user->id) {
    //             return response()->json(['message' => 'Unauthorized'], 403);
    //         }

    //         $booking = Booking::where('shop_id', $shop->id)->with(['customer', 'shopMember'])->findOrFail($bookingId);
    //         return response()->json($booking);
    //     }

    //     if ($user->role === 'customer') {
    //         $booking = Booking::where('customer_id', $user->id)->with(['shop', 'shopMember'])->findOrFail($bookingId);
    //         return response()->json($booking);
    //     }

    //     return response()->json(['message' => 'Unauthorized'], 403);
    // }

    // For Owner: delete booking if needed
    // public function destroy($shopId, $bookingId)
    // {
    //     $user = auth()->user();

    //     if ($user->role !== 'owner') {
    //         return response()->json(['message' => 'Only owners can delete bookings'], 403);
    //     }

    //     $shop = Shop::findOrFail($shopId);

    //     if ($shop->owner_id !== $user->id) {
    //         return response()->json(['message' => 'Unauthorized'], 403);
    //     }

    //     $booking = Booking::where('shop_id', $shop->id)->findOrFail($bookingId);
    //     $booking->delete();

    //     return response()->json(['message' => 'Booking deleted']);
    // }





    // public function store(Request $request)
    // {
    //     // 1. Validation and Setup (Simplified for example)
    //     $validatedData = $request->validate([
    //         'shop_id' => 'required|exists:shops,id',
    //         'staff_id' => 'exists:shop_members,id',
    //         'start_time' => 'required|date_format:Y-m-d H:i:s',
    //         "notes" => "nullable|string|max:1000",
    //         "date" => "required|date|after_or_equal:today",
    //         'services' => 'required|array|min:1',
    //         'services.*.service_id' => 'required|exists:services,id',


    //     ]);

    //     // 2. Fetch Services and Calculate Total Time/Price
    //     $serviceIds = collect($validatedData['services'])->pluck('service_id');
    //     $selectedServices = ShopService::whereIn('id', $serviceIds)->get();

    //     $totalDuration = $selectedServices->sum('duration_minutes');
    //     $totalPrice = $selectedServices->sum('price');

    //     // Calculate the end time
    //     $startTime = new \DateTime($validatedData['start_time']);
    //     $endTimeCalculated = (clone $startTime)->modify("+{$totalDuration} minutes")->format('Y-m-d H:i:s');

    //     // 3. Database Transaction (CRITICAL)
    //     DB::beginTransaction();
    //     try {
    //         // A. Create the Booking Header
    //         $booking = Booking::create([
    //             'customer_id' => auth()->id(),
    //             "shop_id" => $validatedData['shop_id'],
    //             'shop_member_id' => $validatedData['staff_id'],
    //             'start_time' => $validatedData['start_time'],
    //             'end_calculated_time' => $endTimeCalculated,
    //             'shop_id' => $validatedData['shop_id'],
    //             "total_duration" => $totalDuration,
    //             'total_price' => $totalPrice,

    //             'status' => 'pending', // Or 'pending'
    //             // ... other fields
    //         ]);

    //         // B. Prepare and Attach Booking Details
    //         $details = [];
    //         foreach ($validatedData['services'] as $inputService) {
    //             $service = $selectedServices->firstWhere('id', $inputService['service_id']);

    //             $details[] = [
    //                 'service_id' => $service->id,
    //                 'price_at_booking' => $service->price,
    //                 'duration_minutes' => $service->duration_minutes,
    //                 // 'service_order' => $inputService['order'] ?? 1,
    //                 'created_at' => now(), // Needed for mass insertion
    //                 'updated_at' => now(),
    //             ];
    //         }

    //         // Use the relationship to save all details in one go
    //         $booking->details()->createMany($details);

    //         DB::commit();
    //         $booking->load(['details.service', 'shop', 'shopMember']);

    //         return response()->json(['message' => 'Booking created successfully!', 'data' => $booking], 201);
    //     } catch (\Exception $e) {
    //         DB::rollBack();
    //         // Log the error
    //         Log::error('Booking failed: ' . $e->getMessage());
    //         return response()->json(['message' => 'Booking failed due to a server error.', 'error' => $e->getMessage()], 500);
    //     }
    // }
    public function store(Request $request)
    {
        // 1. Validation
        $validatedData = $request->validate([
            'shop_id' => 'required|exists:shops,id',
            // 'staff_id' => 'exists:shop_members,id',
            'start_time' => 'required|date_format:H:i:s',
            "notes" => "nullable|string|max:1000",
            "date" => "required|date|after_or_equal:today",
            'services' => 'required|array|min:1',
            'services.*.service_id' => 'required|exists:services,id',
        ]);
        $startDateTime = Carbon::parse("{$validatedData['date']} {$validatedData['start_time']}");


        // 2. Fetch Services and Calculate Totals
        $serviceIds = collect($validatedData['services'])->pluck('service_id');
        $selectedServices = ShopService::whereIn('id', $serviceIds)->get();

        $totalDuration = $selectedServices->sum('duration');
        $totalPrice = $selectedServices->sum('price');

        // Calculate end time
        // $startTime = new \DateTime($validatedData['start_time']);
        $endTimeCalculated = (clone $startDateTime)->modify("+{$totalDuration} minutes")->format('Y-m-d H:i:s');

        // 3. Transaction
        DB::beginTransaction();
        try {
            // A. Create main booking
            $booking = Booking::create([
                'customer_id' => auth()->id(),
                'shop_id' => $validatedData['shop_id'],
                'shop_member_id' => $validatedData['staff_id'] ?? null,
                'start_time' => $startDateTime->format('Y-m-d H:i:s'),
                'end_calculated_time' => $endTimeCalculated,
                'total_duration' => $totalDuration,
                'total_price' => $totalPrice,
                'status' => 'pending',
                'notes' => $validatedData['notes'] ?? null,
                'date' => $validatedData['date'],
            ]);

            // B. Create booking details
            $details = [];
            foreach ($validatedData['services'] as $inputService) {
                $service = $selectedServices->firstWhere('id', $inputService['service_id']);
                $details[] = [
                    'service_id' => $service->id,
                    'price_at_booking' => $service->price,
                    'duration_minutes' => $service->duration,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }

            $booking->details()->createMany($details);

            DB::commit();

            // 🔹 Load related models to send complete response
            $booking->load(['details.service', 'shop', 'staff']);
            $bookingData = $booking->toArray();

            // Remove unwanted fields
            unset($bookingData['customer_id'], $bookingData['shop_id'], $bookingData['shop_member_id']);
            return response()->json([
                'message' => 'Booking created successfully!',
                'data' => $bookingData,
                "status" => true,
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Booking failed: ' . $e->getMessage());

            return response()->json([
                'message' => 'Booking failed due to a server error.',
                'error' => $e->getMessage(),
                "status" => false,
            ], 500);
        }
    }






    // public function getCustomerBookings(Request $request)
    // {
    //     try {
    //         // 1. Get the authenticated user's ID
    //         $userId = auth()->id();

    //         // 2. Fetch bookings:
    //         //    - Filter by the authenticated user.
    //         //    - Load related data (Eager Loading) to minimize database queries.
    //         $bookings = Booking::where('customer_id', $userId)
    //             ->with(['staff', 'details.service'])
    //             ->orderBy('start_time', 'desc')
    //             ->orderBy('created_at', 'desc')
    //             ->get();



    //         // 3. Transform data for a clean response
    //         $data = $bookings->map(function ($booking) {

    //             return [
    //                 'booking_id' => $booking->id,
    //                 'status' => $booking->status,
    //                 'date' => $booking->date,

    //                 'start_time' => Carbon::parse($booking->start_time)->toDateTimeString(),
    //                 'end_time'   => Carbon::parse($booking->end_time_calculated)->toDateTimeString(),

    //                 'total_price' => (float) $booking->total_price,

    //                 // Staff information
    //                 'staff_details' => [
    //                     'id' => $booking->staff ? $booking->staff->id : null,
    //                     'name' => $booking->staff ? $booking->staff->name  : null,
    //                     "bio" => $booking->staff ? $booking->staff->bio : null,
    //                     "profile_picture" => $booking->staff ? $booking->staff->profile_picture : null,
    //                     "specialization" => $booking->staff ? $booking->staff->specialization : null,
    //                     "role" => $booking->staff ? $booking->staff->role : null,
    //                 ],

    //                 // 'staff_name' => $booking->staff->first_name . ' ' . $booking->staff->last_name,

    //                 // List of services booked
    //                 'services' => $booking->details->map(fn($detail) => [
    //                     'name' => $detail->service->name,
    //                     'duration' => $detail->duration_minutes,
    //                     'price' => (float) $detail->price_at_booking,
    //                 ]),
    //             ];
    //         });
    //         $response = [
    //             'message' => 'Bookings retrieved successfully.',
    //             'data' => $data,
    //             "status" => true,
    //         ];

    //         return response()->json($response, 200);
    //     } catch (\Throwable $th) {
    //         Log::error('Booking failed: ' . $th->getMessage());
    //         return response()->json(['message' => 'Failed to retrieve bookings.', 'error' => $th->getMessage(), "status" => false], 500);
    //     }
    // }
    public function getCustomerBookings(Request $request)
    {
        try {
            $userId = auth()->id();

            // ✅ Load shop along with staff & services
            $bookings = Booking::where('customer_id', $userId)
                ->with(['staff', 'details.service', 'shop'])
                ->orderBy('start_time', 'desc')
                ->orderBy('created_at', 'desc')
                ->get();

            $data = $bookings->map(function ($booking) {
                return [
                    'booking_id' => $booking->id,
                    'status' => $booking->status,
                    'date' => $booking->date,

                    'start_time' => $booking->start_time
                        ? Carbon::parse($booking->start_time)->toDateTimeString()
                        : null,
                    'end_time' => $booking->end_calculated_time
                        ? Carbon::parse($booking->end_calculated_time)->toDateTimeString()
                        : null,

                    'total_price' => (float) $booking->total_price,

                    // ✅ Staff Information
                    'staff_details' => $booking->staff ? [
                        'id' => $booking->staff->id,
                        'name' => $booking->staff->name,
                        'bio' => $booking->staff->bio,
                        'profile_picture' => $booking->staff->profile_picture,
                        'specialization' => $booking->staff->specialization,
                        'role' => $booking->staff->role,
                    ] : null,

                    // ✅ Shop Information (NEW)
                    'shop_details' => $booking->shop ? [
                        'id' => $booking->shop->id,
                        'name' => $booking->shop->name,
                        'address' => $booking->shop->address,
                        'city' => $booking->shop->city,
                        'state' => $booking->shop->state,
                        'pincode' => $booking->shop->pincode,

                        "image" =>  $booking->shop->profile_image
                            ? asset('storage/' . $booking->shop->profile_image)
                            : null,
                        'rating' => $booking->shop->rating,
                        'contact_number' => $booking->shop->contact_number,
                    ] : null,

                    // ✅ Services booked
                    'services' => $booking->details->map(fn($detail) => [
                        'name' => $detail->service->name,
                        'duration' => $detail->duration_minutes,
                        'price' => (float) $detail->price_at_booking,
                    ]),
                ];
            });

            return response()->json([
                'message' => 'Bookings retrieved successfully.',
                'data' => $data,
                'status' => true,
            ], 200);
        } catch (\Throwable $th) {
            Log::error('Booking fetch failed: ' . $th->getMessage());
            return response()->json([
                'message' => 'Failed to retrieve bookings.',
                'error' => $th->getMessage(),
                'status' => false
            ], 500);
        }
    }

    // public function getOwnerBookings(Request $request)
    // {
    //     // 1. Authorization: Ensure the user is an owner/admin/staff
    //     if (!auth()->user()->is_admin && !auth()->user()->is_staff) {
    //         return response()->json(['message' => 'Unauthorized access.'], 403);
    //     }

    //     // 2. Base Query: Start with all confirmed/pending bookings
    //     $query = Booking::with([
    //         'staff:id,first_name,last_name',
    //         'user:id,first_name,last_name,phone,email', // Get customer contact info
    //         'details.service:id,name',
    //     ])->whereIn('status', ['confirmed', 'pending']);

    //     // 3. Apply Staff Filtering (if viewing a specific barber's schedule)
    //     if ($staffId = $request->get('staff_id')) {
    //         $query->where('staff_id', $staffId);
    //     }

    //     // 4. Apply Date Filtering (Crucial for performance)
    //     if ($date = $request->get('date')) {
    //         $query->whereDate('start_time', $date);
    //     } else {
    //         // Default: Show today's appointments if no date is specified
    //         $query->whereDate('start_time', now()->toDateString());
    //     }

    //     $bookings = $query->orderBy('start_time', 'asc')->get();

    //     // 5. Transform data for the Owner/Staff Dashboard
    //     $data = $bookings->map(function ($booking) {
    //         return [
    //             'booking_id' => $booking->id,
    //             'status' => $booking->status,
    //             'start_time' => $booking->start_time->toDateTimeString(),
    //             'end_time' => $booking->end_time_calculated->toDateTimeString(),
    //             'total_price' => (float) $booking->total_price,

    //             // Customer Information (Detailed for owner)
    //             'customer' => [
    //                 'name' => $booking->user->first_name . ' ' . $booking->user->last_name,
    //                 'phone' => $booking->user->phone,
    //                 'email' => $booking->user->email,
    //             ],

    //             // Staff Information
    //             'staff_name' => $booking->staff->first_name,

    //             // List of services booked
    //             'services_booked' => $booking->details->pluck('service.name')->implode(', '),
    //             'total_duration' => $booking->details->sum('duration_minutes'),
    //         ];
    //     });

    //     return response()->json($data);
    // }
    public function getOwnerBookings(Request $request)
    {
        try {
            $ownerId = auth()->id();

            // 1️⃣ Get all shops owned by this owner
            $shopIds = Shop::where('owner_id', $ownerId)->pluck('id');
            // return response()->json($shopIds);

            // 2️⃣ Fetch bookings belonging to those shops
            $bookings = Booking::whereIn('shop_id', $shopIds)
                ->with([
                    'customer:id,name,email', // Load customer info
                    'staff',                  // Load staff info
                    'details.service',        // Load booked services
                    'shop:id,name,profile_image,address', // Load shop info
                ])
                ->orderBy('start_time', 'desc')
                ->orderBy('created_at', 'desc')
                ->get();

            // 3️⃣ Transform response
            $data = $bookings->map(function ($booking) {
                return [
                    'booking_id' => $booking->id,
                    'status' => $booking->status,
                    'date' => $booking->date,

                    'start_time' => Carbon::parse($booking->start_time)->format('Y-m-d H:i:s'),
                    'end_time'   => Carbon::parse($booking->end_time_calculated)->format('Y-m-d H:i:s'),

                    'total_price' => (float) $booking->total_price,
                    "total_duration" => $booking->total_duration,

                    // 🧍 Customer details
                    'customer' => $booking->customer ? [
                        'id' => $booking->customer->id,
                        'name' => $booking->customer->name,
                        'email' => $booking->customer->email,
                    ] : null,

                    // 🧑‍🔧 Staff details
                    'staff' => $booking->staff ? [
                        'id' => $booking->staff->id,
                        'name' => $booking->staff->name,
                        'bio' => $booking->staff->bio,
                        'profile_picture' => $booking->staff->profile_picture,
                        'specialization' => $booking->staff->specialization,
                        'role' => $booking->staff->role,
                    ] : null,

                    // 🏠 Shop details
                    'shop' => $booking->shop ? [
                        'id' => $booking->shop->id,
                        'name' => $booking->shop->name,
                        'profile_image' => url('storage/' . $booking->shop->profile_image),
                        'address' => $booking->shop->address,
                    ] : null,

                    // 💇 Services
                    'services' => $booking->details->map(fn($detail) => [
                        'name' => $detail->service->name,
                        'duration' => $detail->duration_minutes,
                        'price' => (float) $detail->price_at_booking,
                    ]),
                ];
            });

            // 4️⃣ Send final response
            return response()->json([
                'message' => 'Owner bookings retrieved successfully.',
                'data' => $data,
                "status" => true,
            ], 200);
        } catch (\Throwable $th) {
            Log::error('Owner bookings retrieval failed: ' . $th->getMessage());
            return response()->json([
                'message' => 'Failed to retrieve owner bookings.',
                'error' => $th->getMessage(),
                "status" => false,
            ], 500);
        }
    }

    public function updateStatusByUser(Request $request, $bookingId)
    {
        try {
            $user = auth()->user();

            $booking = Booking::find($bookingId);
            if ($booking->customer_id !== $user->id) {
                return response()->json(['message' => 'Unauthorized', "status" => false], 403);
            }


            $request->validate([
                'status' => 'required|in:completed,cancelled_by_customer,customer_not_arrived, rescheduled_by_customer',
            ]);

            $booking->status = $request->status;
            $booking->save();
            $response = [
                'message' => 'Booking status updated successfully.',
                'data' => $booking,
                "status" => true,
            ];

            return response()->json($response, 200);
        } catch (\Throwable $th) {
            Log::error('Booking status update failed: ' . $th->getMessage());
            return response()->json([
                'message' => 'Failed to update booking status.',
                'error' => $th->getMessage(),
                "status" => false,
            ], 500);
        }
    }

    public function updateStatusByOwner(Request $request, $bookingId)
    {
        try {
            $user = auth()->user();
            if ($user->role !== 'owner') {
                return response()->json(['message' => 'Only owners can update bookings', "status" => false], 403);
            }
            $shop = Shop::where('owner_id', $user->id)->first();
            if (!$shop) {
                return response()->json(['message' => 'Unauthorized', "status" => false], 403);
            }

            $booking = Booking::find($bookingId);
            if ($booking->shop_id !== $shop->id) {
                return response()->json(['message' => 'Unauthorized sdfs', "status" => false], 403);
            }
            $request->validate([
                'status' => 'required|in:confirmed,cancelled_by_owner,customer_not_arrived',
            ]);
            $booking->status = $request->status;
            $booking->save();
            $response = [
                'message' => 'Booking status updated successfully.',
                'data' => $booking,
                "status" => true,
            ];
            return response()->json($response, 200);
        } catch (\Throwable $th) {
            Log::error('Booking status update failed: ' . $th->getMessage());
            return response()->json([
                'message' => 'Failed to update booking status.',
                'error' => $th->getMessage(),
                "status" => false,
            ], 500);
        }
    }
}
