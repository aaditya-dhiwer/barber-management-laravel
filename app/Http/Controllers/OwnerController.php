<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Shop;

class OwnerController extends Controller
{

    public function index(Request $request)
    {
        $statusLabels = [
            1 => 'Shop Create',
            2 => 'Service Create',
            3 => 'Workers Create',
            5 => 'Approved',
            6 => 'Declined',
        ];

        $query = Shop::query();

        if ($request->filter && $request->filter !== 'all') {
            $query->where('current_step', $request->filter);
        }

        $shops = $query->orderByRaw("current_step = 4 DESC")
            ->orderBy('created_at', 'DESC')
            ->get();

        return view('admin.shops.index', compact('shops', 'statusLabels'));
    }

    public function updateStatus(Request $request, Shop $shop)
    {
        $shop->current_step = $request->status == 'approve' ? 5 : 6;
        $shop->save();

        return redirect()->back()->with('success', 'Shop status updated successfully!');
    }

    public function show(Shop $shop)
    {
        // Assuming relations exist: services, workers, owner (User)
        $owner = $shop->owner ?? null;  // If you have user relationship

        // $owner = User::find($shop->owner_id) ?? null;
        $services = $shop->services ?? [];
        $workers = $shop->members ?? [];

        return view('admin.shops.show', compact('shop', 'owner', 'services', 'workers'));
    }
}
