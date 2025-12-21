// import 'package:flutter/material.dart';

// class DashboardBottomNav extends StatelessWidget {
//   const DashboardBottomNav({super.key});

//   Widget _buildBottomNavItem(IconData icon, String label, bool isActive) {
//     return Column(
//       children: [
//         Icon(icon, color: isActive ? Colors.green : Colors.grey[400], size: 24),
//         const SizedBox(height: 5),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: isActive ? Colors.green : Colors.grey[400],
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildBottomNavItem(Icons.home_filled, 'Home', true),
//           _buildBottomNavItem(Icons.trending_up, 'Trends', false),
//           _buildBottomNavItem(Icons.favorite, 'Favorites', false),
//           _buildBottomNavItem(Icons.person, 'Profile', false),
//         ],
//       ),
//     );
//   }
// }
