<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\ShopController;
use App\Http\Controllers\ShopMemberController;
use App\Http\Controllers\BookingController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ServiceController;
use App\Http\Controllers\ServiceCategoryController;
use App\Http\Controllers\ShopServiceController;
use App\Http\Controllers\OwnerController;


// Route::middleware(['auth:sanctum', 'can:isOwner'])->group(function () {
//     Route::get('/shops/mine', [ShopController::class, 'myShop']);
// });
Route::post('/register', [AuthController::class, 'register']);
Route::post('/resend-otp', [AuthController::class, 'resendOtp']);
Route::post('/forgot-password', [AuthController::class, 'sendResetLink']);
Route::post('/verify-otp', [AuthController::class, 'verifyOtp']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/owner-login', [AuthController::class, 'ownerLogin']);
// Route::apiResource('shops', ShopController::class);

Route::get('/services/full_menu', [ServiceController::class, 'getFullMenu']);
Route::get('/get-all-shops', [ShopController::class, 'getAllShopForUsers']);
Route::middleware('auth:sanctum')->group(function () {

    Route::post('/logout', [AuthController::class, 'logout']);
    Route::apiResource('/service-category', ServiceCategoryController::class);

    // Owner routes
    Route::middleware('can:isOwner')->group(function () {
        Route::apiResource('shops', ShopController::class);
        Route::get('get-current-step', [ShopController::class, 'getCurrentShopStatus']);

        Route::post('approve/{shopId}', [ShopController::class, 'approvedShop']);
        Route::apiResource('shops/members', ShopMemberController::class);
        Route::prefix('shops/{shop}')->group(function () {
            Route::apiResource('bookings', BookingController::class);
        });

        Route::post('/services', [ServiceController::class, 'store']);
        Route::apiResource('/shop-services', ShopServiceController::class);

        Route::get('/get-owner-bookings', [BookingController::class, 'getOwnerBookings']);
    });

    // Customer routes
    Route::middleware('can:isCustomer')->group(function () {
        Route::get('/shops/nearest', [ShopController::class, 'nearest']);
        // Route::apiResource('/bookings', BookingController::class);
        Route::post('/bookings', [BookingController::class, 'store']);
        Route::get('/get-customer-bookings', [BookingController::class, 'getCustomerBookings']);
    });
});



// Admin routes will be here in future
