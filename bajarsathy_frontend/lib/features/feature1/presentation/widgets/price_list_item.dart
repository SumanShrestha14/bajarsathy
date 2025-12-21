import 'package:bajarsathy_frontend/features/feature1/domain/entities/prices.dart';
import 'package:flutter/material.dart';

class PriceListItem extends StatelessWidget {
  final Prices price;
  final int index;
  final int totalItems;
  final VoidCallback? onTap;

  const PriceListItem({
    super.key,
    required this.price,
    required this.index,
    required this.totalItems,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: index % 2 == 0 ? Colors.green[50] : Colors.white,
        borderRadius: index == 0
            ? const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
            : index == totalItems - 1
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )
                : BorderRadius.zero,
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              price.product_name[0],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ),
        title: Text(
          price.product_name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          'Rs. ${price.avg_price} per ${price.unit}',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}

