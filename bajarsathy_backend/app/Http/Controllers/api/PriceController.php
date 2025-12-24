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
    $request->validate([
        'products' => 'required|array',
        'products.*.product_name' => 'required|string',
        'products.*.unit' => 'nullable|string',
        'products.*.min_price' => 'nullable|string',
        'products.*.max_price' => 'nullable|string',
        'products.*.avg_price' => 'nullable|string',
        'products.*.created_at' => 'nullable|date',
    ]);

    $inserted = [];

    foreach ($request->products as $product) {

        // auto image copy logic
        $existing = PriceModel::where('product_name', $product['product_name'])
            ->whereNotNull('product_image')
            ->first();

        if ($existing) {
            $product['product_image'] = $existing->product_image;
        }

        $inserted[] = PriceModel::create($product);
    }

    return response()->json([
        'status' => 'success',
        'count'  => count($inserted),
        'data'   => $inserted
    ], 201);
}


    // Optional: List all prices
    public function index($date)
    {
        // Validate date format
        if (!Carbon::hasFormat($date, 'Y-m-d')) {
            return response()->json([
                'status' => 'error',
                'message' => 'Invalid date format. Use Y-m-d'
            ], 422);
        }

        $prices = PriceModel::whereDate('created_at', $date)->get();

        return response()->json([
            'status' => 'success',
            'date' => $date,
            'data' => $prices
        ]);
    }

public function priceTrend(Request $request)
{
    $request->validate([
        'product_name' => 'required|string'
    ]);

    $productName = $request->product_name;

    // Get all records for this product sorted oldest → newest
    $records = PriceModel::where('product_name', $productName)
        ->orderBy('created_at', 'asc')
        ->get(['product_name','unit','created_at', 'min_price', 'max_price', 'avg_price', 'product_image']);

    if ($records->isEmpty()) {
        return response()->json([
            'message' => 'No price data found for this product',
            'data' => []
        ], 404);
    }

    // Format data
    $data = $records->map(function($record) {
        return [
            'product_name' => $record->product_name,
            'unit' => $record->unit,
            'date' => $record->created_at->toDateString(),
            'min_price' => (float) $record->min_price,
            'max_price' => (float) $record->max_price,
            'avg_price' => (float) $record->avg_price,
            'product_image' => $record->product_image 
                ? url('uploads/products/' . $record->product_image) 
                : null
        ];
    });

    // Return response
    return response()->json([
        'product_name' => $productName,
        'data' => $data
    ]);
}


}
