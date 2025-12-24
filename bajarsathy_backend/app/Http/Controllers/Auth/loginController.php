<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class loginController extends Controller
{
    // Handle Login
    public function showLoginForm()
    {
        return view('show.login');
    }
public function login(Request $request)
{
    $request->validate([
        'email'    => 'required|email',
        'password' => 'required|min:6',
    ]);

    $user = User::where('email', $request->email)->first();
   if (!$user) {
            // Handle case when user is not found
            return back()->withErrors(['email' => 'Unauthorized User !']);
        }
        
    if ($user) {
        // Check if user is blocked
        if ($user->attempt_flag == 1) {
            // Check if 1 hour has passed since block
            if ($user->blocked_at && Carbon::parse($user->blocked_at)->diffInMinutes(now()) >= 60) {
                // Unblock
                $user->attempt_flag = 0;
                $user->login_attempts = 0;
                $user->blocked_at = null;
                $user->save();
            } else {
                return back()->withErrors([
                    'email' => 'You are temporarily blocked. Try again after 1 hour.',
                ]);
            }
        }

        // Attempt login
        if (Auth::attempt($request->only('email', 'password'))) {
            $request->session()->regenerate();

            // Reset attempts on success
            $user->login_attempts = 0;
            $user->attempt_flag = 0;
            $user->blocked_at = null;
            $user->save();

            return redirect()->intended('/dashboard');
        } else {
            // Track failed attempt
            $user->increment('login_attempts');

            if ($user->login_attempts >= 10) {
                $user->attempt_flag = 1;
                $user->blocked_at = now();
            }

            $user->save();
        }
    }

    return back()->withErrors([
        'email' => 'The provided credentials are incorrect. (' .$user->login_attempts .')',
    ]);
}

    // Handle Logout
    public function logout(Request $request)
    {
        Auth::logout();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return redirect('/');
    }
    
}