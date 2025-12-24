<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        /* Custom scrollbar for sidebar */
        .sidebar-scroll::-webkit-scrollbar {
            width: 4px;
        }
        .sidebar-scroll::-webkit-scrollbar-track {
            background: transparent;
        }
        .sidebar-scroll::-webkit-scrollbar-thumb {
            background: #4b5563;
            border-radius: 2px;
        }
        
        /* Mobile sidebar transitions */
        #mobile-sidebar {
            transition: all 0.3s ease;
        }
        
        /* Profile dropdown animation */
        .dropdown-menu {
            animation: fadeIn 0.2s ease-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        /* Submenu transitions */
        .submenu {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease;
        }
        .submenu.open {
            max-height: 500px;
        }
    </style>
</head>
<body class="bg-gray-50 font-sans">
    <div class="flex h-screen overflow-hidden">
        <!-- Desktop Sidebar -->
        <div class="hidden md:flex md:flex-shrink-0">
            <div class="flex flex-col w-64 bg-gray-800">
                <div class="flex items-center h-16 px-4 bg-gray-900">
                    <img src="https://www.iconpacks.net/icons/2/free-user-icon-3296-thumb.png" 
                         alt="dashboard" class="h-8 w-8 rounded-full">
                    <h1 class="text-white font-bold text-xl ml-3">Dashboard</h1>
                </div>
                <div class="flex flex-col flex-grow px-4 py-4 overflow-y-auto sidebar-scroll">
                    <nav class="flex-1 space-y-2">
                        <a href="/dashboard"
                            class="flex items-center px-4 py-2 text-gray-300 hover:bg-gray-700 hover:text-white rounded-md transition-colors duration-200">
                            <i class="fas fa-tachometer-alt mr-3"></i>
                            Dashboard
                        </a>
                        <a href="/data"
                            class="flex items-center px-4 py-2 text-gray-300 hover:bg-gray-700 hover:text-white rounded-md transition-colors duration-200">
                            <i class="fas fa-users mr-3"></i>
                            View Datas
                        </a>
                        
                        <!-- Student Management Dropdown -->
                        <div class="relative">
                            <button class="w-full flex items-center justify-between px-4 py-2 text-gray-300 hover:bg-gray-700 hover:text-white rounded-md transition-colors duration-200 sidebar-dropdown">
                                <div class="flex items-center">
                                    <i class="fas fa-user-graduate mr-3"></i>
                                    <span>Students</span>
                                </div>
                                <i class="fas fa-chevron-down text-xs transition-transform duration-200"></i>
                            </button>
                            <div class="submenu ml-8 pl-2 border-l-2 border-gray-600">
                                <a href="/students"
                                    class="block px-3 py-2 text-sm text-gray-300 hover:bg-gray-700 hover:text-white rounded-md transition-colors">Add Students</a>
                                <a href="/students/view"
                                    class="block px-3 py-2 text-sm text-gray-300 hover:bg-gray-700 hover:text-white rounded-md transition-colors">View Students</a>
                            </div>
                        </div>
                    </nav>
                </div>
                <div class="p-4 border-t border-gray-700">
                    <div class="flex items-center">
                        <img class="w-8 h-8 rounded-full" 
                             src="https://www.iconpacks.net/icons/2/free-user-icon-3296-thumb.png" alt="User avatar">
                        <div class="ml-3">
                            <p class="text-sm font-medium text-white">{{$admin->name}}</p>
                            <p class="text-xs text-gray-400">Admin</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Mobile Sidebar Overlay -->
        <div class="md:hidden fixed inset-0 z-40 hidden" id="mobile-sidebar">
            <div class="fixed inset-0 bg-black bg-opacity-50" id="sidebar-overlay"></div>
            <div class="relative flex flex-col w-72 bg-gray-800 h-full transform -translate-x-full" id="sidebar-content">
                <div class="flex items-center h-16 px-4 bg-gray-900">
                    <img src="https://www.iconpacks.net/icons/2/free-user-icon-3296-thumb.png" 
                         alt="dashboard" class="h-8 w-8 rounded-full">
                    <h1 class="text-white font-bold text-xl ml-3">Dashboard</h1>
                    <button type="button" class="ml-auto p-2 rounded-md text-gray-300 hover:text-white hover:bg-gray-700" id="close-sidebar">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div class="flex flex-col flex-grow px-4 py-4 overflow-y-auto sidebar-scroll">
                    <nav class="flex-1 space-y-2">
                        <a href="/dashboard"
                            class="flex items-center px-4 py-2 text-gray-300 hover:bg-gray-700 hover:text-white rounded-md transition-colors duration-200">
                            <i class="fas fa-tachometer-alt mr-3"></i>
                            Dashboard
                        </a>
                        <a href="/visitors"
                            class="flex items-center px-4 py-2 text-gray-300 hover:bg-gray-700 hover:text-white rounded-md transition-colors duration-200">
                            <i class="fas fa-users mr-3"></i>
                            Visitors
                        </a>
                        
                        <!-- Student Management Dropdown (Mobile) -->
                        <div class="relative">
                            <button class="w-full flex items-center justify-between px-4 py-2 text-gray-300 hover:bg-gray-700 hover:text-white rounded-md transition-colors duration-200 mobile-sidebar-dropdown">
                                <div class="flex items-center">
                                    <i class="fas fa-user-graduate mr-3"></i>
                                    <span>Students</span>
                                </div>
                                <i class="fas fa-chevron-down text-xs transition-transform duration-200"></i>
                            </button>
                            <div class="submenu ml-8 pl-2 border-l-2 border-gray-600">
                                <a href="/students"
                                    class="block px-3 py-2 text-sm text-gray-300 hover:bg-gray-700 hover:text-white rounded-md transition-colors">Add Students</a>
                                <a href="/students/view"
                                    class="block px-3 py-2 text-sm text-gray-300 hover:bg-gray-700 hover:text-white rounded-md transition-colors">View Students</a>
                            </div>
                        </div>
                    </nav>
                </div>
                <div class="p-4 border-t border-gray-700">
                    <div class="flex items-center">
                        <img class="w-8 h-8 rounded-full" 
                             src="https://www.iconpacks.net/icons/2/free-user-icon-3296-thumb.png" alt="User avatar">
                        <div class="ml-3">
                            <p class="text-sm font-medium text-white">{{$admin->name}}</p>
                            <p class="text-xs text-gray-400">Admin</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main content -->
        <div class="flex flex-col flex-1 overflow-hidden">
            <!-- Header -->
            <header class="flex items-center justify-between h-16 px-4 bg-white border-b border-gray-200 shadow-sm">
                <div class="flex items-center">
                    <button type="button" class="p-2 text-gray-600 rounded-md md:hidden hover:text-gray-800 hover:bg-gray-100" id="open-sidebar">
                        <i class="fas fa-bars"></i>
                    </button>
                    <h2 class="ml-2 text-lg font-semibold text-gray-800">Dashboard</h2>
                    <span class="px-2 hidden md:block text-gray-300">|</span>
                    <h2 class="text-lg font-semibold text-gray-800 hidden md:block">
                        <span class="font-medium text-sm">Welcome Back,</span> 
                        <span class="font-bold text-blue-600">{{$admin->name}}</span>
                    </h2>
                </div>
                <div class="flex items-center space-x-4">
                    <!-- Profile dropdown -->
                    <div class="relative">
                        <button type="button" class="flex items-center space-x-2 focus:outline-none" id="user-menu-button">
                            <span class="text-sm font-medium text-gray-700 hidden md:block">{{$admin->name}}</span>
                            <img class="w-8 h-8 rounded-full hover:scale-105 transition-transform" 
                                 src="https://www.iconpacks.net/icons/2/free-user-icon-3296-thumb.png" alt="User avatar">
                        </button>
                        <!-- Profile dropdown menu -->
                        <div class="hidden absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-10 dropdown-menu" id="user-menu">
                            <div class="px-4 py-2 border-b border-gray-100">
                                <p class="text-sm font-semibold text-gray-800">User Information:</p>
                            </div>
                            <a href="/profile"
                                class="flex items-center gap-2 px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900 transition-colors">
                                <i class="fas fa-user-circle"></i> Your Profile
                            </a>
                            <a href="/settings"
                                class="flex items-center gap-2 px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900 transition-colors">
                                <i class="fas fa-cog"></i> Settings
                            </a>
                            <button type="button" onclick="showLogoutConfirmation()"
                                class="flex items-center gap-2 px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900 transition-colors w-full text-start">
                                <i class="fas fa-sign-out-alt"></i> Sign out
                            </button>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Main content area -->
            <main class="flex-1 overflow-y-auto p-4 md:p-6">
                @yield('content');
            </main>
        </div>

          <div id="logoutConfirmation"
            class="hidden fixed inset-0 z-50 bg-black/60 backdrop-blur-sm flex items-center justify-center">
            <div class="bg-white w-full max-w-md m-4 p-6 rounded-xl shadow-xl animate-fadeInUp border border-gray-100">
                <div class="flex items-start gap-4">
                    <div class="bg-red-100 text-red-600 rounded-full p-2">
                        <!-- Heroicon: ArrowLeftOnRectangle (Logout Icon) -->
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" stroke-width="1.8" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M15.75 9V5.25A2.25 2.25 0 0013.5 3h-6A2.25 2.25 0 005.25 5.25v13.5A2.25 2.25 0 007.5 21h6a2.25 2.25 0 002.25-2.25V15M18 12H8.25M15 9l3 3m0 0l-3 3" />
                        </svg>
                    </div>
                    <div class="flex-1">
                        <h2 class="text-lg font-semibold text-gray-800">Log Out?</h2>
                        <p class="text-sm text-gray-600 mt-1">
                            Are you sure you want to log out from your account? Please confirm to continue.
                        </p>
                    </div>
                </div>

                <div class="mt-6 flex justify-end gap-3">
                    <button onclick="hideLogoutConfirmation()"
                        class="px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 hover:bg-gray-200 rounded-md transition">
                        Cancel
                    </button>

                    <form action="{{ route('logout') }}" method="POST" onsubmit="disableSubmitButton()">
                        @csrf
                        <button id="send"
                            class="px-4 py-2 text-sm font-medium text-white bg-red-600 hover:bg-red-700 rounded-md transition">
                            Log Out
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Mobile sidebar functionality
        const openSidebar = document.getElementById('open-sidebar');
        const closeSidebar = document.getElementById('close-sidebar');
        const mobileSidebar = document.getElementById('mobile-sidebar');
        const sidebarOverlay = document.getElementById('sidebar-overlay');
        const sidebarContent = document.getElementById('sidebar-content');

        function openMobileSidebar() {
            mobileSidebar.classList.remove('hidden');
            setTimeout(() => {
                sidebarOverlay.style.opacity = '1';
                sidebarContent.style.transform = 'translateX(0)';
            }, 10);
        }

        function closeMobileSidebar() {
            sidebarOverlay.style.opacity = '0';
            sidebarContent.style.transform = 'translateX(-100%)';
            setTimeout(() => {
                mobileSidebar.classList.add('hidden');
            }, 300);
        }

        openSidebar.addEventListener('click', openMobileSidebar);
        closeSidebar.addEventListener('click', closeMobileSidebar);
        sidebarOverlay.addEventListener('click', closeMobileSidebar);

        // Profile dropdown functionality
        const userMenuButton = document.getElementById('user-menu-button');
        const userMenu = document.getElementById('user-menu');

        userMenuButton.addEventListener('click', (e) => {
            e.stopPropagation();
            userMenu.classList.toggle('hidden');
        });

        // Close dropdown when clicking outside
        document.addEventListener('click', (e) => {
            if (!userMenuButton.contains(e.target) && !userMenu.contains(e.target)) {
                userMenu.classList.add('hidden');
            }
        });

        // Close dropdown on escape key
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && !userMenu.classList.contains('hidden')) {
                userMenu.classList.add('hidden');
            }
        });

        // Sidebar dropdown functionality
        document.querySelectorAll('.sidebar-dropdown, .mobile-sidebar-dropdown').forEach(button => {
            button.addEventListener('click', function() {
                const submenu = this.nextElementSibling;
                const icon = this.querySelector('.fa-chevron-down');
                
                submenu.classList.toggle('open');
                icon.classList.toggle('rotate-90');
            });
        });
        function showLogoutConfirmation() {
            document.getElementById('logoutConfirmation').classList.remove('hidden');
        }

        function hideLogoutConfirmation() {
            document.getElementById('logoutConfirmation').classList.add('hidden');
        }

        function submitLogoutForm() {
            // Replace with your logout logic
            console.log("Logged out.");
            // Example: document.getElementById('logoutForm').submit();
        }

        // Close sidebar on window resize to desktop
        window.addEventListener('resize', () => {
            if (window.innerWidth >= 768) {
                closeMobileSidebar();
            }
        });

        // Initialize mobile sidebar position
        sidebarContent.style.transform = 'translateX(-100%)';
        sidebarOverlay.style.opacity = '0';
        sidebarOverlay.style.transition = 'opacity 0.3s ease';
        sidebarContent.style.transition = 'transform 0.3s ease';
    </script>
</body>
</html>