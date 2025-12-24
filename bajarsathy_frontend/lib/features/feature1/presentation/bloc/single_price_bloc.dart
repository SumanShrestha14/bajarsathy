import 'package:bajarsathy_frontend/features/feature1/domain/usecases/get_single_price.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/bloc/single_price_event.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/bloc/single_price_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SinglePriceBloc extends Bloc<SinglePriceEvent, SinglePriceState> {
  final GetSinglePrice getSinglePrices;

  SinglePriceBloc(this.getSinglePrices) : super(SinglePriceInitial()) {
    on<FetchSingleDataEvent>(_onFetchSingleData);
  }

  Future<void> _onFetchSingleData(
    FetchSingleDataEvent event,
    Emitter<SinglePriceState> emit,
  ) async {
    emit(SinglePriceLoading());
    try {
      final singlePrices = await getSinglePrices(event.product_name);
      emit(SinglePriceLoaded(singlePrices));
    } catch (e, stackTrace) {
      debugPrint('SinglePriceBloc Error: $e');
      debugPrint('Stack Trace: $stackTrace');
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(SinglePriceError(errorMessage));
    }
  }
}
