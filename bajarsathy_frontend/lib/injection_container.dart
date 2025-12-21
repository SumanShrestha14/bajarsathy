import 'package:bajarsathy_frontend/features/feature1/data/datasources/price_data_source.dart';
import 'package:bajarsathy_frontend/features/feature1/data/repositories/price_repository_impl.dart';
import 'package:bajarsathy_frontend/features/feature1/domain/repositories/price_repository.dart';
import 'package:bajarsathy_frontend/features/feature1/domain/usecases/get_prices.dart';
import 'package:bajarsathy_frontend/features/feature1/presentation/bloc/price_bloc.dart';
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

  // Repository
  sl.registerLazySingleton<PriceRepository>(() => PriceRepositoryImpl(sl()));

  // Use case
  sl.registerLazySingleton(() => GetPrices(sl()));

  // Bloc
  sl.registerFactory(() => PriceBloc(sl()));
}
