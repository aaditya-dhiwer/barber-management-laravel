<?php

use App\Http\Controllers\AuthController;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\OwnerController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/reset-password', [AuthController::class, 'showResetForm'])->name('password.reset');
Route::post('/reset-password', [AuthController::class, 'handleReset'])->name('password.update');


Route::prefix('admin')->group(function () {
    Route::get('/owners', [OwnerController::class, 'index'])->name('owners.index');
    Route::post('/owners/approve/{id}', [OwnerController::class, 'approveShop'])->name('shop.approve');
    Route::post('/owners/decline/{id}', [OwnerController::class, 'declineShop'])->name('shop.decline');
});
