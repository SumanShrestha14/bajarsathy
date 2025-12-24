import 'package:bajarsathy_frontend/features/feature1/data/datasources/price_data_source.dart';
import 'package:bajarsathy_frontend/features/feature1/data/datasources/single_price_data_source.dart';
import 'package:bajarsathy_frontend/features/feature1/data/repositories/price_repository_impl.dart';
import 'package:bajarsathy_frontend/features/feature1/data/repositories/single_price_repository_impl.dart';
import 'package:bajarsathy_frontend/features/feature1/domain/repositories/price_repository.dart';
import 'package:bajarsathy_frontend/features/feature1/domain/repositories/single_price_repository.dart';
import 'package:bajarsathy_frontend/features/feature1/domain/usecases/get_prices.dart';
import 'package:bajarsathy_frontend/features/feature1/domain/usecases/get_single_price.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/bloc/price_bloc.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/bloc/single_price_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Data source
  sl.registerLazySingleton<PriceDataSource>(
    () => PriceDataSourceImplemention(sl()),
  );
  sl.registerLazySingleton<SinglePriceDataSource>(
    () => SinglePriceDataSourceImplemention(sl()),
  );

  // Repository
  sl.registerLazySingleton<PriceRepository>(() => PriceRepositoryImpl(sl()));
  sl.registerLazySingleton<SinglePriceRepository>(
    () => SinglePriceRepositoryImpl(sl()),
  );
  // Use case
  sl.registerLazySingleton(() => GetPrices(sl()));
  sl.registerLazySingleton(() => GetSinglePrice(sl()));
  // Bloc
  sl.registerFactory(() => PriceBloc(sl()));
  sl.registerFactory(() => SinglePriceBloc(sl()));
}
