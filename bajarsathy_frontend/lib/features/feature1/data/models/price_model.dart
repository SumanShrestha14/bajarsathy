import 'package:bajarsathy_frontend/features/feature1/domain/entities/prices.dart';

class PriceModel extends Prices {
  PriceModel({
    required String product_name,
    required String unit,
    required String min_price,
    required String max_price,
    required String avg_price,
  }) : super(
         product_name: product_name,
         unit: unit,
         min_price: min_price,
         max_price: max_price,
         avg_price: avg_price,
       );

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      product_name: json['product_name'],
      unit: json['unit'],
      min_price: json['min_price'],
      max_price: json['max_price'],
      avg_price: json['avg_price'],
    );
  }
}
