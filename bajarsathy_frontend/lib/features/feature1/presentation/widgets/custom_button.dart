import 'package:bajarsathy_frontend/features/feature1/presentation/pages/price_page.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final IconData icon; // ✅ correct type
  final VoidCallback? onTap;

  const CustomButton({
    super.key,
    required this.btnText,
    required this.icon,
    required this.onTap,
  });

  void handleButtonTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PricePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 58, 57, 58),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              btnText,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            Icon(icon, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}
