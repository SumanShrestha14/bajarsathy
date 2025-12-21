import 'package:bajarsathy_frontend/features/feature1/data/datasources/price_data_source.dart';
import 'package:bajarsathy_frontend/features/feature1/domain/entities/prices.dart';
import 'package:bajarsathy_frontend/features/feature1/domain/repositories/price_repository.dart';
import 'package:flutter/foundation.dart';

class PriceRepositoryImpl implements PriceRepository {
  final PriceDataSource remoteDataSource;

  PriceRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Prices>> getPrices() async {
    try {
      return await remoteDataSource.getPrices();
    } catch (e) {
      debugPrint('Repository Error: $e');
      rethrow;
    }
  }
}
