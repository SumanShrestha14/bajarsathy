import 'package:bajarsathy_frontend/features/feature1/domain/entities/single_price.dart';

class SinglePriceModel extends SinglePrice {
  SinglePriceModel({
    required String product_name,
    required String unit,
    required String min_price,
    required String max_price,
    required String avg_price,
    required String? product_image,
  }) : super(
         product_name: product_name,
         unit: unit,
         min_price: min_price,
         max_price: max_price,
         avg_price: avg_price,
         product_image: product_image,
       );

  factory SinglePriceModel.fromJson(Map<String, dynamic> json) {
    return SinglePriceModel(
      product_name: json['product_name']?.toString() ?? '',
      unit: json['unit']?.toString() ?? '',
      min_price: json['min_price']?.toString() ?? '',
      max_price: json['max_price']?.toString() ?? '',
      avg_price: json['avg_price']?.toString() ?? '',
      product_image: json['product_image']?.toString(),
    );
  }
}
