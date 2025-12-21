import 'package:bajarsathy_frontend/features/feature1/presentation/widgets/dashboard_bottom_nav.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/widgets/recent_changes_section.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/widgets/vegetable_prices_section.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/widgets/view_all_button.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/widgets/welcome_section.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'बजार साथी',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        leading: Icon(Icons.sunny, color: Colors.white),
        backgroundColor: Colors.green[800],
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.remove_red_eye_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeSection(),
            const SizedBox(height: 20),
            const RecentChangesSection(),
            const SizedBox(height: 25),
            const VegetablePricesSection(),
            const SizedBox(height: 30),
            const ViewAllButton(),
            const SizedBox(height: 30),
            // const DashboardBottomNav(),
          ],
        ),
      ),
    );
  }
}
