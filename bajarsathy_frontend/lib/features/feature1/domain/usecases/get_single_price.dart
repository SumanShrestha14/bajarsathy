import 'package:bajarsathy_frontend/features/feature1/domain/entities/single_price.dart';
import 'package:bajarsathy_frontend/features/feature1/domain/repositories/single_price_repository.dart';

class GetSinglePrice {
  final SinglePriceRepository repository;

  GetSinglePrice(this.repository);

  Future<SinglePrice> call(String productName) {
    return repository.getSinglePrice(productName);
  }
}
