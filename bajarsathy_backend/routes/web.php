<?php

use App\Http\Controllers\Auth\loginController;
use App\Http\Controllers\dataController;
use Illuminate\Support\Facades\Route;


// Public routes
Route::get('/', [loginController::class, 'showLoginForm'])->name('login'); // Show login form
Route::post('/', [loginController::class, 'login']); // Handle login

Route::post('/logout', [loginController::class, 'logout'])->name('logout'); // Handle logout


Route::middleware(['auth'])->group(function () {

    Route::get('/dashboard', function () {
        return view('dashboard');
    })->name('dashboard');//view options to create the doc
    // Protected routes





Route::get('/data', [dataController::class, 'viewTodayPrices'])->name('prices.today');
Route::put('/data/{id}', [dataController::class, 'updateImage'])->name('prices.updateImage');


});