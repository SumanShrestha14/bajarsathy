<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\PriceController;

Route::middleware('api.key')->group(function () {
    Route::get('/prices', [PriceController::class, 'index']);
    Route::post('/prices', [PriceController::class, 'store']);
});
