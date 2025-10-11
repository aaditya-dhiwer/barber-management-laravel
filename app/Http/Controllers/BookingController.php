<?php
// app/Http/Controllers/BookingController.php

namespace App\Http\Controllers;

use App\Models\Booking;
use App\Models\Shop;
use App\Models\ShopMember;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;

class BookingController extends Controller
{
    // For Owner: list bookings for a shop
    public function index(Request $request, $shopId = null)
    {
        $user = auth()->user();

        if ($user->role === 'owner') {
            $shop = Shop::findOrFail($shopId);

            if ($shop->owner_id !== $user->id) {
                return response()->json(['message' => 'Unauthorized'], 403);
            }
            $bookings = $shop->bookings()->with(['customer', 'shopMember'])->get();
            return response()->json($bookings);
        }

        if ($user->role === 'customer') {
            $bookings = Booking::where('customer_id', $user->id)->with(['shop', 'shopMember'])->get();
            return response()->json($bookings);
        }

        return response()->json(['message' => 'Unauthorized'], 403);
    }

    // For Customer: create booking
    public function store(Request $request)
    {
        $user = auth()->user();

        if ($user->role !== 'customer') {
            return response()->json(['message' => 'Only customers can create bookings'], 403);
        }

        $request->validate([
            'shop_id' => 'required|exists:shops,id',
            'shop_member_id' => 'nullable|exists:shop_members,id',
            'date' => 'required|date|after_or_equal:today',
            'time' => 'required|date_format:H:i',
        ]);

        $shop = Shop::findOrFail($request->shop_id);

        if ($request->shop_member_id) {
            $member = ShopMember::where('shop_id', $shop->id)->findOrFail($request->shop_member_id);
        }

        $booking = Booking::create([
            'shop_id' => $shop->id,
            'shop_member_id' => $request->shop_member_id,
            'customer_id' => $user->id,
            'date' => $request->date,
            'time' => $request->time,
            'status' => 'pending',
        ]);

        return response()->json($booking, 201);
    }

    // For Owner: update booking status
    public function update(Request $request, $shopId, $bookingId)
    {
        $user = auth()->user();

        if ($user->role !== 'owner') {
            return response()->json(['message' => 'Only owners can update bookings'], 403);
        }

        $shop = Shop::findOrFail($shopId);

        if ($shop->owner_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $booking = Booking::where('shop_id', $shop->id)->findOrFail($bookingId);

        $request->validate([
            'status' => 'required|in:pending,confirmed,cancelled',
        ]);

        $booking->status = $request->status;
        $booking->save();

        return response()->json($booking);
    }

    // For Owner or Customer: show booking details
    public function show(Request $request, $shopId = null, $bookingId)
    {
        $user = auth()->user();

        if ($user->role === 'owner') {
            $shop = Shop::findOrFail($shopId);

            if ($shop->owner_id !== $user->id) {
                return response()->json(['message' => 'Unauthorized'], 403);
            }

            $booking = Booking::where('shop_id', $shop->id)->with(['customer', 'shopMember'])->findOrFail($bookingId);
            return response()->json($booking);
        }

        if ($user->role === 'customer') {
            $booking = Booking::where('customer_id', $user->id)->with(['shop', 'shopMember'])->findOrFail($bookingId);
            return response()->json($booking);
        }

        return response()->json(['message' => 'Unauthorized'], 403);
    }

    // For Owner: delete booking if needed
    public function destroy($shopId, $bookingId)
    {
        $user = auth()->user();

        if ($user->role !== 'owner') {
            return response()->json(['message' => 'Only owners can delete bookings'], 403);
        }

        $shop = Shop::findOrFail($shopId);

        if ($shop->owner_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $booking = Booking::where('shop_id', $shop->id)->findOrFail($bookingId);
        $booking->delete();

        return response()->json(['message' => 'Booking deleted']);
    }
}
