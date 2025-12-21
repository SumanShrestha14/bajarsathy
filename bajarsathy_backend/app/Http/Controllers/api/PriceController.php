<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\PriceModel;
use Illuminate\Http\Request;
use App\Models\Price;
use Carbon\Carbon;

class PriceController extends Controller
{
    // Store a new price
    public function store(Request $request)
    {
        $validated = $request->validate([
            'product_name' => 'required|string',
            'unit'         => 'nullable|string',
            'min_price'    => 'nullable|string',
            'max_price'    => 'nullable|string',
            'avg_price'    => 'nullable|string',
        ]);

        $price = PriceModel::create($validated);

        return response()->json([
            'status' => 'success',
            'data'   => $price
        ], 201);
    }

    // Optional: List all prices
public function index($date)
{
    // Validate date format
    if (!Carbon::hasFormat($date, 'Y-m-d')) {
        return response()->json([
            'status'  => 'error',
            'message' => 'Invalid date format. Use Y-m-d'
        ], 422);
    }

    $prices = PriceModel::whereDate('created_at', $date)->get();

    return response()->json([
        'status' => 'success',
        'date'   => $date,
        'data'   => $prices
    ]);
}
}
