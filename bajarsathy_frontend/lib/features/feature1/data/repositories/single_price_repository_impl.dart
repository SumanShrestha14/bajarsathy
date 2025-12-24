import 'package:bajarsathy_frontend/features/feature1/data/datasources/single_price_data_source.dart';
import 'package:bajarsathy_frontend/features/feature1/domain/entities/single_price.dart';
import 'package:bajarsathy_frontend/features/feature1/domain/repositories/single_price_repository.dart';
import 'package:flutter/material.dart';

class SinglePriceRepositoryImpl implements SinglePriceRepository {
  final SinglePriceDataSource remoteDataSource;

  SinglePriceRepositoryImpl(this.remoteDataSource);

  @override
  Future<SinglePrice> getSinglePrice(String productName) async {
    try {
      return await remoteDataSource.getSinglePrice(productName);
    } catch (e) {
      debugPrint('Repository Error: $e');
      rethrow;
    }
  }
}
