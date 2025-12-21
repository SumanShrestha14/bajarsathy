import 'package:bajarsathy_frontend/features/feature1/domain/entities/prices.dart';
import 'package:bajarsathy_frontend/features/feature1/domain/repositories/price_repository.dart';

class GetPrices {
  final PriceRepository repository;

  GetPrices(this.repository);

  Future<List<Prices>> call() {
    return repository.getPrices();
  }
}
