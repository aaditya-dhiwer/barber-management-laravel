<?php
// app/Http/Controllers/ShopMemberController.php

namespace App\Http\Controllers;

use App\Models\ShopMember;
use App\Models\Shop;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rule;

class ShopMemberController extends Controller
{
    public function index($shopId)
    {
        try {
            $shop = Shop::findOrFail($shopId);

            if (Gate::denies('isOwner') || auth()->id() !== $shop->owner_id) {
                return response()->json(['message' => 'Unauthorized'], 403);
            }

            $members = $shop->members()->get();

            return response()->json($members);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Error occurred: ' . $e->getMessage()], 500);
        }
    }

    public function store(Request $request)
    {
        try {
            DB::beginTransaction();

            $user = auth()->user();

            if (Gate::denies('isOwner')) {
                return response()->json(['message' => 'Unauthorized', "status" => false], 403);
            }
            $shop = Shop::where('owner_id', $user->id)->first();   
            if (!$shop) {
                return response()->json(['message' => 'Shop not found', "status" => false], 404);
            }

            $request->validate([
                "member" => 'required|array',
                'member.*name' => 'required|string|max:255',
                'member.*profile_image' => 'nullable|image|max:2048',
                'member.*specialty' => 'nullable|string',
                'member.*phone' => 'nullable|string|max:15',
                'member.*bio' => 'nullable|string',
                'member.*dob' => 'nullable',
                'member.*receive_sms_promotions' => 'nullable|boolean',
                'member.*receive_email_promotions' => 'nullable|boolean',
                'role' => ['nullable', Rule::in(['staff', 'manager', 'owner'])],

            ]);

            $members = [];
            foreach ($request->input('member') as $index => $memberData) {
                $data = [
                    'shop_id' => $shop->id,
                    'name' => $memberData['name'] ?? null,
                    'specialty' => $memberData['specialty'] ?? null,
                    'phone' => $memberData['phone'] ?? null,
                    'bio' => $memberData['bio'] ?? null,
                    'role' => $request->input('role', 'staff'),
                    'dob' => $memberData['dob'] ?? null,
                    'receive_sms_promotions' => $memberData['receive_sms_promotions'] ?? true,
                    'receive_email_promotions' => $memberData['receive_email_promotions'] ?? true
                ];

                if ($request->hasFile("member.$index.profile_image")) {
                    $path = $request->file("member.$index.profile_image")->store('shop_members', 'public');
                    $data['profile_image'] = $path;
                } elseif (!empty($memberData['profile_image'])) {
                    // In case profile_image is a string (URL or path)
                    $data['profile_image'] = $memberData['profile_image'];
                }

                $member = ShopMember::create($data);

                if (!empty($member->profile_image)) {
                    $member->profile_image = url(Storage::url($member->profile_image));
                }

                $members[] = $member;
            }

            // After member successfully created changed the current_step of shop to 3
            // Update current_step only if not already completed
            if ($shop->current_step == 2) {
                $shop->status = 'pending';
                $shop->current_step = 3;
                $shop->save();
            }

            DB::commit();
            $response = ["message" => "Shop member created successfully", "member" => $members, "status" => true];

            return response()->json($response, 201);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => 'Error occurred: ' . $e->getMessage(), "status" => false], 500);
        }
    }

    public function show($shopId, $memberId)
    {
        $member = ShopMember::where('shop_id', $shopId)->findOrFail($memberId);

        if (Gate::denies('isOwner') || auth()->id() !== $member->shop->owner_id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        return response()->json($member);
    }

    public function update(Request $request, $shopId, $memberId)
    {
        $member = ShopMember::where('shop_id', $shopId)->findOrFail($memberId);

        if (Gate::denies('isOwner') || auth()->id() !== $member->shop->owner_id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $request->validate([
            'name' => 'sometimes|required|string|max:255',
            'profile_image' => 'nullable|image|max:2048',
            'specialty' => 'nullable|string|max:255',
        ]);

        if ($request->hasFile('profile_image')) {
            // Delete old image if exists
            if ($member->profile_image) {
                Storage::disk('public')->delete($member->profile_image);
            }
            $path = $request->file('profile_image')->store('shop_members', 'public');
            $member->profile_image = $path;
        }

        $member->fill($request->only(['name', 'specialty']));
        $member->save();

        return response()->json($member);
    }

    public function destroy($shopId, $memberId)
    {
        $member = ShopMember::where('shop_id', $shopId)->findOrFail($memberId);

        if (Gate::denies('isOwner') || auth()->id() !== $member->shop->owner_id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        if ($member->profile_image) {
            Storage::disk('public')->delete($member->profile_image);
        }

        $member->delete();

        return response()->json(['message' => 'Deleted successfully']);
    }
}
