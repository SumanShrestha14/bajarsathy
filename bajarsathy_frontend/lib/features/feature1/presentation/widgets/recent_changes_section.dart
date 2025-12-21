import 'package:bajarsathy_frontend/features/feature1/presentation/widgets/price_change_item.dart';
import 'package:flutter/material.dart';

class RecentChangesSection extends StatelessWidget {
  const RecentChangesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '🔥 Recent Changes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                const PriceChangeItem(name: 'Suman', change: '5', isPositive: true),
                const Divider(height: 20, color: Colors.grey),
                const PriceChangeItem(name: 'Shrestha', change: '10', isPositive: true),
                const Divider(height: 20, color: Colors.grey),
                const PriceChangeItem(name: 'Gaurav', change: '5', isPositive: false),
                const Divider(height: 20, color: Colors.grey),
                const PriceChangeItem(name: 'Basnet', change: '3', isPositive: false),
                const Divider(height: 20, color: Colors.grey),
                const PriceChangeItem(name: 'IOEPC', change: '1', isPositive: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

