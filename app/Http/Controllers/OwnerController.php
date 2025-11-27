<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Shop;

class OwnerController extends Controller
{

    public function getOwners()
    {
        $owners = User::where('role', 'owner')
            ->with([
                'shops.images',
                'shops.services.service',
                'shops.members.user' 
            ])
            ->get();

        return response()->json($owners);
    }

    public function updateShopStep(Request $request, $id)
    {
        $shop = \App\Models\Shop::findOrFail($id);
        $shop->current_step = $request->status; // 5 for approve, 6 for decline
        $shop->save();

        return response()->json(['message' => 'Status updated successfully']);
    }
}
