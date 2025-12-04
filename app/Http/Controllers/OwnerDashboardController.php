<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class OwnerDashboardController extends Controller
{
    public function dashboard()
    {
        try {
            $shop = auth()->user()->shops->first(); // hasOne relation

            if (!$shop) {
                return response()->json([
                    'error' => 'Shop not found for this user',
                    "status" => false
                ], 404);
            }
            if ($shop->current_step != 5) {
                return response()->json([
                    'error' => 'Shop is not approved yet',
                    "status" => false
                ], 403);
            }

            $todaysBookings = $shop->bookings()
                ->whereDate('created_at', now()->toDateString())
                ->count();

            $todaysEarnings = $shop->bookings()
                ->whereDate('created_at', now()->toDateString())
                ->sum('total_price'); // total from bookings table

            $totalBookings = $shop->bookings()->count();

            $totalEarnings = $shop->bookings()->sum('total_price');
            $workers = $shop->members()->count();

            $upcommingBookings = $shop->bookings()
                ->whereDate('date', '>=', now()->toDateString())
                ->orderBy('date', 'asc')
                ->get();
            $response = ["message" => "Dashboard data retrieved successfully", "status" => true, "data" => [
                'todays_bookings' => $todaysBookings,
                'todays_earnings' => $todaysEarnings,
                'total_bookings' => $totalBookings,
                'total_earnings' => $totalEarnings,
                'total_workers' => $workers,
                'upcoming_bookings' => $upcommingBookings,
            ]];
            return response()->json($response);
        } catch (\Throwable $th) {
            return response()->json(['error' => 'Failed to retrieve dashboard data', 'message' => $th->getMessage(), "status" => false], 500);
        }
    }
}
