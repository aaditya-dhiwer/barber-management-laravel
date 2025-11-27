<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;

use Illuminate\Support\Str;
use App\Mail\ResetPasswordMail;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;
use App\Models\PendingVerification;
use App\Mail\OtpMail;
use App\Models\Shop;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;
use Carbon\Carbon;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        try {
            $validation = Validator::make($request->all(), [
                'name' => 'required|string|max:255',
                'email' => 'required|string|email|unique:users',
                'password' => 'required|string|min:6',
                'role' => 'required|in:owner,customer',
            ]);
            if ($validation->fails()) {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => $validation->errors(),
                    'status' => false
                ], 422);
            }

            $otp = rand(100000, 999999);

            PendingVerification::updateOrCreate(
                ['email' => $request->email],
                [
                    'name'       => $request->name,
                    'password'   => bcrypt($request->password),
                    'otp'        => $otp,
                    'expires_at' => now()->addMinutes(10),
                    'role'       => $request->role,
                ]
            );

            Mail::to($request->email)->send(new OtpMail($otp));

            return response()->json([
                'message' => 'OTP sent to your email. Please verify to complete registration.',
                "status" => true
            ], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Registration failed', "status" => false], 400);
        }
    }

    public function verifyOtp(Request $request)
    {
        try {
            $validation = Validator::make($request->all(), [
                'email' => 'required|string|email',
                'otp' => 'required|string',
            ]);
            if ($validation->fails()) {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => $validation->errors(),
                    'status' => false
                ], 422);
            }

            $pending = PendingVerification::where('email', $request->email)
                ->where('otp', $request->otp)
                ->first();

            if (!$pending || $pending->isExpired()) {
                return response()->json(['message' => 'Invalid or expired OTP', 'status' => false], 400);
            }

            // Create the actual user now
            $user = User::create([
                'name' => $pending->name,
                'email' => $pending->email,
                'password' => $pending->password,
                'role' => $pending->role,
                'email_verified_at' => now(),
            ]);

            $pending->delete();

            return response()->json(['message' => 'Email verified. You can now log in.', "status" => true]);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Invalid OTP', "status" => false], 400);
        }
    }

    public function login(Request $request)
    {
        try {
            $request->validate([
                'email' => 'required|string|email',
                'password' => 'required|string',
            ]);

            $user = User::where('email', $request->email)->first();

            if (! $user || ! Hash::check($request->password, $user->password)) {
                throw ValidationException::withMessages([
                    'email' => ['The provided credentials are incorrect.'],
                ]);
            }




            // Revoke previous tokens
            // $user->tokens()->delete();

            $token = $user->createToken('auth_token')->plainTextToken;


            $step = 1;
            if ($user->role == "owner") {
                $shop = Shop::where('owner_id', $user->id)->first();
                if ($shop) {
                    $step =  $shop->current_step;
                }
                return response()->json([
                    'access_token' => $token,
                    'user' => $user,
                    "role" => $user->role,
                    "current_step" => $step,
                    "status" => true,
                ]);
            }
            return response()->json([
                'access_token' => $token,
                'user' => $user,
                "role" => $user->role,
                "status" => true,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Login failed',
                'status' => false
            ], 400);
        }
    }


    public function logout(Request $request)
    {
        try {
            $request->user()->tokens()->delete();
            return response()->json(['message' => 'Logged out']);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Logout failed',
                'status' => false
            ], 400);
        }
    }

    public function resendOtp(Request $request)
    {
        try {
            $validation = Validator::make($request->all(), [
                'email' => 'required|string|email|exists:pending_verifications,email',
            ]);

            if ($validation->fails()) {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => $validation->errors(),
                    'status' => false
                ], 422);
            }

            // Find existing record
            $pendingUser = PendingVerification::where('email', $request->email)->first();

            if (!$pendingUser) {
                return response()->json([
                    'message' => 'No pending verification found for this email.',
                    'status'  => false
                ], 404);
            }

            // Generate new OTP
            $otp = rand(100000, 999999);

            // Update existing pending verification
            $pendingUser->update([
                'otp'        => $otp,
                'expires_at' => now()->addMinutes(10),
            ]);

            // Send mail again
            Mail::to($request->email)->send(new OtpMail($otp));

            return response()->json([
                'message' => 'OTP resent successfully to your email.',
                'status'  => true
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to resend OTP',
                'status'  => false,
                'error'   => $e->getMessage()
            ], 400);
        }
    }




    public function sendResetLink(Request $request)
    {
        $request->validate([
            'email' => 'required|email|exists:users,email',
        ]);


        $token = Str::random(64);


        DB::table('password_resets')->updateOrInsert(
            ['email' => $request->email],
            [
                'token' => hash('sha256', $token),
                'created_at' => now(),
            ]
        );

        // The link where frontend reset form is hosted
        $frontendUrl = url('/reset-password?token=' . $token . '&email=' . urlencode($request->email));

        Mail::to($request->email)->send(new ResetPasswordMail($frontendUrl));

        return response()->json([
            'message' => 'Password reset link sent to your email.',
            'status' => true,
            // "link" => $frontendUrl, // For testing purposes only 
        ]);
    }

    public function showResetForm(Request $request)
    {
        $email = $request->query('email');
        $plainToken = $request->query('token');

        if (!$email || !$plainToken) {
            return view('auth.reset-message', [
                'message' => 'Invalid reset link.',
                'type' => 'error'
            ]);
        }

        // Check token
        $hashedToken = hash('sha256', $plainToken);
        $record = DB::table('password_resets')
            ->where('email', $email)
            ->where('token', $hashedToken)
            ->first();



        if (!$record) {
            return view('auth.reset-message', [
                'message' => 'This reset link is invalid or already used.',
                'type' => 'error'
            ]);
        }

        // Expiry check (60 min)
        if (Carbon::parse($record->created_at)->addMinutes(60)->isPast()) {
            DB::table('password_resets')->where('email', $email)->delete();
            return view('auth.reset-message', [
                'message' => 'This reset link has expired.',
                'type' => 'error'
            ]);
        }

        // ❌ Delete token immediately → one-time use
        DB::table('password_resets')->where('email', $email)->delete();

        return view('auth.reset-form', [
            'email' => $email,
            'token' => $plainToken,
        ]);
    }

    // ✅ Handle password reset submission
    public function handleReset(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required|string|min:6|confirmed',
        ]);

        $user = User::where('email', $request->email)->first();
        if (!$user) {
            return view('auth.reset-message', [
                'message' => 'Invalid user.',
                'type' => 'error'
            ]);
        }

        $user->update([
            'password' => Hash::make($request->password),
        ]);

        return view('auth.reset-message', [
            'message' => 'Your password has been changed successfully!',
            'type' => 'success'
        ]);
    }

    public function ownerLogin(Request $request)
    {
        try {
            $step = 1;

            $request->validate([
                'email' => 'required|string|email',
                'password' => 'required|string',
            ]);

            $user = User::where('email', $request->email)->first();

            if (! $user || ! Hash::check($request->password, $user->password)) {
                throw ValidationException::withMessages([
                    'email' => ['The provided credentials are incorrect.'],
                ]);
            }
            if ($user->role !== 'owner') {
                return response()->json([
                    'message' => 'Access denied. Not an owner.',
                    'status' => false
                ], 403);
            }



            $shop = Shop::where('owner_id', $user->id)->first();
            if ($shop) {
                $step =  $shop->current_step;
            }
            // Revoke previous tokens
            $user->tokens()->delete();
            $token = $user->createToken('auth_token')->plainTextToken;



            return response()->json([
                'access_token' => $token,
                'user' => $user,
                "role" => $user->role,
                "current_step" => $step,
                // "shop" => $shop ? $shop : null,  
                "status" => true
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Login failed',
                'status' => false
            ], 400);
        }
    }
}
