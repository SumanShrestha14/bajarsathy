class SinglePrice {
  final String product_name;
  final String unit;
  final String max_price;
  final String min_price;
  final String avg_price;
  final String? product_image;

  SinglePrice({
    required this.product_name,
    required this.unit,
    required this.min_price,
    required this.max_price,
    required this.avg_price,
    this.product_image,
  });
}
