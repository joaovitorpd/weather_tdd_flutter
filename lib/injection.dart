import 'package:get_it/get_it.dart';
import 'package:weather_tdd_flutter/data/datasources/remote_data_source.dart';
import 'package:weather_tdd_flutter/data/repository/weather_repository_impl.dart';
import 'package:weather_tdd_flutter/domain/repositories/weather_repository.dart';
import 'package:weather_tdd_flutter/domain/usecases/get_current_weather.dart';
import 'package:weather_tdd_flutter/presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  //usecase
  locator.registerLazySingleton(() => GetCurrentWeather(locator()));

  //respository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(remoteDataSource: locator()),
  );

  //data source
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: locator()),
  );

  //external
  locator.registerLazySingleton(() => http.Client());
}
