import 'package:flutter/material.dart';

class PriceChangeItem extends StatelessWidget {
  final String name;
  final String change;
  final bool isPositive;

  const PriceChangeItem({
    super.key,
    required this.name,
    required this.change,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isPositive ? Colors.green[50] : Colors.red[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isPositive ? Colors.green : Colors.red,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isPositive ? Colors.green[50] : Colors.red[50],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            '${isPositive ? '+' : ''}$change%',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isPositive ? Colors.green : Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}

