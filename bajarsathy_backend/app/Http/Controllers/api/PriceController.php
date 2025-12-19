<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\PriceModel;
use Illuminate\Http\Request;

class PriceController extends Controller
{
    // Store a new price
    public function store(Request $request)
    {
        $validated = $request->validate([
            'product_name' => 'required|string',
            'unit'         => 'nullable|string',
            'min_price'    => 'nullable|numeric',
            'max_price'    => 'nullable|numeric',
            'avg_price'    => 'nullable|numeric',
        ]);

        $price = PriceModel::create($validated);

        return response()->json([
            'status' => 'success',
            'data'   => $price
        ], 201);
    }

    // Optional: List all prices
    public function index()
    {
        $prices = PriceModel::all();
        return response()->json([
            'status' => 'success',
            'data'   => $prices
        ]);
    }
}
