import 'package:bajarsathy_frontend/features/feature1/domain/entities/prices.dart';

abstract class PriceRepository {
  Future<List<Prices>> getPrices();
}
