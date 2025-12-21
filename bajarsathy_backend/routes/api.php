<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\PriceController;

Route::middleware('api.key')->group(function () {
    Route::post('/prices', action: [PriceController::class, 'store']);
        Route::get('/prices/{date}', [PriceController::class, 'index']);

});
