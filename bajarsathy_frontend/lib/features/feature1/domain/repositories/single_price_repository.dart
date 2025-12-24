import 'package:bajarsathy_frontend/features/feature1/domain/entities/single_price.dart';

abstract class SinglePriceRepository {
  Future<SinglePrice> getSinglePrice(String productName);
}
