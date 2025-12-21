import 'package:flutter/material.dart';

class Topchange extends StatelessWidget {
  final String productName;
  final String changeNumber;
  const Topchange({
    super.key,
    required this.productName,
    required this.changeNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          productName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            color: (int.parse(changeNumber)) > 0
                ? Colors.lightGreen
                : Colors.redAccent,
          ),
          child: Text(changeNumber, style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
