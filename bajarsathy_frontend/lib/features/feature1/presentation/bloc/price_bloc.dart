import 'package:bajarsathy_frontend/features/feature1/domain/usecases/get_prices.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/bloc/price_event.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/bloc/price_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  final GetPrices getPrices;

  PriceBloc(this.getPrices) : super(PriceInitial()) {
    on<FetchDataEvent>(_onFetchData);
  }

  Future<void> _onFetchData(
    FetchDataEvent event,
    Emitter<PriceState> emit,
  ) async {
    emit(PriceLoading());
    try {
      final prices = await getPrices();
      emit(PriceLoaded(prices));
    } catch (e, stackTrace) {
      debugPrint('PriceBloc Error: $e');
      debugPrint('Stack Trace: $stackTrace');
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(PriceError(errorMessage));
    }
  }
}
