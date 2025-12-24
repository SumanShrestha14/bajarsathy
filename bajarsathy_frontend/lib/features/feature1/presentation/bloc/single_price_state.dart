import 'package:bajarsathy_frontend/features/feature1/domain/entities/single_price.dart';

abstract class SinglePriceState {}

class SinglePriceInitial extends SinglePriceState {}

class SinglePriceLoading extends SinglePriceState {}

class SinglePriceLoaded extends SinglePriceState {
  final SinglePrice prices;

  SinglePriceLoaded(this.prices);
}

class SinglePriceError extends SinglePriceState {
  final String message;
  SinglePriceError(this.message);
}
