import 'package:bajarsathy_frontend/features/feature1/domain/entities/prices.dart';

abstract class PriceState {}

class PriceInitial extends PriceState {}

class PriceLoading extends PriceState {}

class PriceLoaded extends PriceState {
  final List<Prices> prices;

  PriceLoaded(this.prices);
}

class PriceError extends PriceState {
  final String message;
  PriceError(this.message);
}
