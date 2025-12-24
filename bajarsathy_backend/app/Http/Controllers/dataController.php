<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\PriceModel;
use Carbon\Carbon;
use Illuminate\Support\Facades\Storage;


class dataController extends Controller
{
public function viewTodayPrices()
{
    // Get today's date
    $today = Carbon::today();

    // Fetch records created today
    $prices = PriceModel::whereDate('created_at', $today)->get();

    return view('data', compact('prices'));
}

public function updateImage(Request $request, $id)
{
    $price = PriceModel::findOrFail($id);

    if ($request->hasFile('product_image')) {
        $file = $request->file('product_image');
        $filename = time() . '_' . $file->getClientOriginalName();
        $file->move(public_path('uploads/products'), $filename);

        // Delete old image if exists
        if ($price->product_image && file_exists(public_path('uploads/products/' . $price->product_image))) {
            unlink(public_path('uploads/products/' . $price->product_image));
        }

        $price->product_image = $filename;
        $price->save();
    }

    return redirect()->back()->with('success', 'Image updated successfully.');
}
}

