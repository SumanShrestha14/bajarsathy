<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\PriceController;

// Get all prices
Route::get('/prices', [PriceController::class, 'index']);

// Store a new price
Route::post('/prices', [PriceController::class, 'store']);
