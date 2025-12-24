<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>Admin Portal</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        .mobile-view {
            display: block;
        }

        .desktop-view {
            display: none;
        }

        @media (min-width: 768px) {
            .mobile-view {
                display: none;
            }

            .desktop-view {
                display: block;
            }
        }

        .shake-error {
            animation: shake 0.5s;
        }

        @keyframes shake {

            0%,
            100% {
                transform: translateX(0);
            }

            10%,
            30%,
            50%,
            70%,
            90% {
                transform: translateX(-5px);
            }

            20%,
            40%,
            60%,
            80% {
                transform: translateX(5px);
            }
        }

        .gradient-bg {
            background: linear-gradient(135deg, #6b46c1 0%, #805ad5 100%);
        }

        .gradient-bg {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .form-group {
            transition: all 0.3s ease;
        }

        .form-group:focus-within {
            transform: translateY(-2px);
        }
    </style>
</head>

<body class="bg-gray-100 min-h-screen flex items-center justify-center p-0 md:p-4">
    <!-- Mobile App-like Login View -->
    <div class="block md:hidden mobile-view w-full h-screen flex flex-col">
        <!-- App Header with Gradient Background -->
        <div class="gradient-bg p-6 text-white flex flex-col items-center justify-center" style="height: 35vh;">
            <div
                class="w-20 h-20 bg-white  rounded-full flex items-center justify-center mb-4 shadow-lg overflow-hidden">
                <!-- Replace with your image -->
                <img src="assests/logo1.png" alt="App Logo" class="w-14 h-14 object-contain">
            </div>
            <h1 class="text-2xl font-bold mb-1">Welcome Back</h1>
            <p class="text-white text-opacity-90">Sign in to continue</p>
        </div>

        <!-- Login Form Container with Curved Top -->
        <div class="bg-white rounded-t-3xl -mt-8 flex-grow p-6 pt-8 shadow-lg">
            @if($errors->any())
                <div id="mobileErrorMessage"
                    class="mb-4 p-3 bg-red-50 border-l-4 border-red-500 text-red-700 rounded-lg animate__animated animate__shakeX">
                    <i class="fas fa-exclamation-circle mr-2"></i>
                    <span id="mobileErrorText">{{ $errors->first() }}</span>
                </div>
            @endif

            <form id="mobileLoginForm" method="POST" action="{{ route('login') }}" class="space-y-5">
                @csrf
                <!-- Email Field -->
                <div class="form-group">
                    <label class="block text-gray-700 text-sm font-medium mb-2">Email Address</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-envelope text-gray-400"></i>
                        </div>
                        <input type="email" id="mobileEmail" name="email"
                            class="w-full pl-10 pr-3 py-3 border border-gray-200 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            placeholder="your@email.com" value="{{ old('email') }}" required
                            style="background-color: #f8f9fa;">
                    </div>
                </div>

                <!-- Password Field -->
                <div class="form-group">
                    <label class="block text-gray-700 text-sm font-medium mb-2">Password</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-lock text-gray-400"></i>
                        </div>
                        <input type="password" id="mobilePassword" name="password"
                            class="w-full pl-10 pr-10 py-3 border border-gray-200 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            placeholder="••••••••" required style="background-color: #f8f9fa;">

                    </div>
                </div>

                <!-- Remember Me & Forgot Password -->
                <div class="flex items-center justify-between">
                    <div class="flex items-center">

                    </div>
                    @if (Route::has('password.request'))
                        <a href="{{ route('password.request') }}"
                            class="text-sm text-purple-600 hover:text-purple-800 font-medium">Forgot password?</a>
                    @endif
                </div>

                <!-- Submit Button -->
                <button type="submit" id="mobileLoginBtn"
                    class="w-full gradient-bg hover:opacity-90 text-white font-bold py-4 px-4 rounded-xl shadow-lg transition duration-200 mt-6">
                    <span id="mobileBtnText">Sign In</span>
                    <i class="fas fa-arrow-right ml-2"></i>
                </button>
            </form>

            <!-- Footer Links -->
            <div class="mt-8 text-center">
                <p class="text-sm text-gray-500">Need help? <a href="/contact" class="text-purple-600 font-medium">Contact
                        Support</a></p>
            </div>
            <br><br>
            <footer class="text-center text-xs text-gray-400 mt-8">
                © 2025 Developed by <a href="https://atsnp.com.np">AT Solution Nepal Pvt Ltd</a>
            </footer>
        </div>
    </div>


    <!-- Desktop View -->
    <div class="desktop-view w-full max-w-3xl">
        <div class="bg-white rounded-2xl shadow-xl overflow-hidden flex animate__animated animate__fadeIn scale-90">
            <!-- Left Side - Graphic -->
            <div class="hidden md:block md:w-1/2 gradient-bg p-4 text-white">
                <div class="h-full flex flex-col justify-center items-center">

                    <div
                        class="p-2.5 rounded-full bg-gray-100 w-32 h-32 flex items-center justify-center shadow-[inset_0_4px_8px_0_rgba(0,0,0,0.1)]">
                        <img src="assests/logo1.png" alt="Admin Dashboard"
                            class="w-20 h-20 object-cover animate__animated animate__zoomIn"> <!-- Fixed w-23 → w-20 -->
                    </div>

                    <h2 class="text-2xl font-bold mb-2 animate__animated animate__fadeIn">Welcome Back</h2>
                    <p class="text-white text-opacity-80 mb-8 text-center animate__animated animate__fadeIn">Log in
                        securely to access your MIS Dashboard.</p>

                    <div class="space-y-4 w-full max-w-xs animate__animated animate__fadeInUp">
                        <div class="flex items-center bg-white bg-opacity-10 p-3 rounded-lg">
                            <i class="fas fa-shield-alt mr-3"></i>
                            <span>Enterprise-Grade Security</span>
                        </div>
                        <div class="flex items-center bg-white bg-opacity-10 p-3 rounded-lg">
                            <i class="fas fa-tachometer-alt mr-3"></i>
                            <span>Real-time analytics</span>
                        </div>
                        <div class="flex items-center bg-white bg-opacity-10 p-3 rounded-lg">
                            <i class="fas fa-users-cog mr-3"></i>
                            <span>Student & User Management</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Side - Login Form -->
            <div class="w-full md:w-1/2 p-4">
                <div class="flex justify-center mb-6 animate__animated animate__bounceIn">
                    <div class="bg-purple-100 p-4 rounded-full">
                        <i class="fas fa-user-shield text-purple-600 text-3xl"></i>
                    </div>
                </div>

                <h2 class="text-2xl font-bold text-gray-800 mb-2 text-center animate__animated animate__fadeIn">Admin
                    Login</h2>
                <p class="text-gray-500 text-center mb-6 animate__animated animate__fadeIn">Enter your credentials to
                    continue</p>

                @if($errors->any())
                    <div id="desktopErrorMessage"
                        class="mb-4 p-3 bg-red-100 border-l-4 border-red-500 text-red-700 rounded-lg animate__animated animate__shakeX">
                        <i class="fas fa-exclamation-triangle mr-2"></i>
                        <span id="desktopErrorText">{{ $errors->first() }}</span>
                    </div>
                @else
                    <div id="desktopErrorMessage"
                        class="hidden mb-4 p-3 bg-red-100 border-l-4 border-red-500 text-red-700 rounded-lg animate__animated animate__shakeX">
                        <i class="fas fa-exclamation-triangle mr-2"></i>
                        <span id="desktopErrorText"></span>
                    </div>
                @endif

                <form id="desktopLoginForm" method="POST" action="{{ route('login') }}">
                    @csrf
                    <div class="mb-4 animate__animated animate__fadeInLeft">
                        <label class="block text-gray-700 text-sm font-medium mb-2">Email Address</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-envelope text-gray-400"></i>
                            </div>
                            <input type="email" id="desktopEmail" name="email"
                                class="w-full pl-10 pr-3 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                                placeholder="admin@example.com" value="{{ old('email') }}" required>
                        </div>
                    </div>

                    <div class="mb-6 animate__animated animate__fadeInRight">
                        <label class="block text-gray-700 text-sm font-medium mb-2">Password</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-lock text-gray-400"></i>
                            </div>
                            <input type="password" id="desktopPassword" name="password"
                                class="w-full pl-10 pr-3 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                                placeholder="••••••••" required>

                        </div>
                    </div>

                    <div class="flex items-center justify-between mb-6 animate__animated animate__fadeIn">
                        <div class="flex items-center">

                        </div>
                        @if (Route::has('password.request'))
                            <a href="{{ route('password.request') }}"
                                class="text-sm text-purple-600 hover:text-purple-800 font-medium">Forgot password?</a>
                        @endif
                    </div>

                    <button type="submit" id="desktopLoginBtn"
                        class="w-full gradient-bg hover:opacity-90 text-white font-medium py-3 px-4 rounded-xl shadow-lg transform hover:scale-[1.02] transition duration-200 animate__animated animate__zoomIn">
                        <span id="desktopBtnText">Login to Dashboard</span>
                        <i class="fas fa-arrow-right ml-2"></i>
                    </button>
                </form>

                <div class="mt-6 text-center text-sm text-gray-500 animate__animated animate__fadeIn animate__delay-1s">
                    <p>Need an account? <a href="/contact" class="text-purple-600 font-medium">Contact Support</a></p>
                </div>

            </div>
        </div>

        <footer class="text-center text-xs text-gray-400 mt-8">
            © 2025 Developed by <a href="https://atsnp.com.np">AT Solution Nepal Pvt Ltd</a>
        </footer>
    </div>





    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Password toggle for mobile
            const mobileToggle = document.getElementById('mobileTogglePassword');
            const mobilePassword = document.getElementById('mobilePassword');
            if (mobileToggle && mobilePassword) {
                mobileToggle.addEventListener('click', function () {
                    const type = mobilePassword.getAttribute('type') === 'password' ? 'text' : 'password';
                    mobilePassword.setAttribute('type', type);
                    mobileToggle.innerHTML = type === 'password' ? '<i class="fas fa-eye"></i>' : '<i class="fas fa-eye-slash"></i>';
                });
            }

            // Form submission handlers for loading states
            const mobileLoginForm = document.getElementById('mobileLoginForm');
            if (mobileLoginForm) {
                mobileLoginForm.addEventListener('submit', function (e) {
                    const button = document.getElementById('mobileLoginBtn');
                    if (button) {
                        button.disabled = true;
                        button.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i> Authenticating';
                        // Allow the form to submit normally
                    }
                });
            }

            const desktopLoginForm = document.getElementById('desktopLoginForm');
            if (desktopLoginForm) {
                desktopLoginForm.addEventListener('submit', function (e) {
                    const button = document.getElementById('desktopLoginBtn');
                    if (button) {
                        button.disabled = true;
                        button.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i> Authenticating';
                        // Allow the form to submit normally
                    }
                });
            }
        });
    </script>



    <script>

        document.addEventListener("contextmenu", function (e) {
            e.preventDefault();
        });


        document.addEventListener("keydown", function (e) {

            if (e.keyCode === 123) {
                e.preventDefault();
            }

            if (e.ctrlKey && e.shiftKey && e.keyCode === 73) {
              e.preventDefault();
            }

            if (e.ctrlKey && e.keyCode === 85) {
                e.preventDefault();
            }

            if (e.ctrlKey && e.keyCode === 83) {
                e.preventDefault();
            }

            if (e.ctrlKey && e.shiftKey && e.keyCode === 67) {
                e.preventDefault();
            }
        });


        document.addEventListener("dragstart", function (e) {
            e.preventDefault();
        });


        document.addEventListener("selectstart", function (e) {
            e.preventDefault();
        });


        (function () {
            const devtools = new Image();
            Object.defineProperty(devtools, 'id', {
                get: function () {
                    alert('DevTools is not allowed!');
                    throw new Error("DevTools blocked");
                }
            });
            console.log('%c', devtools);
        })();
    </script>

</body>

</html>