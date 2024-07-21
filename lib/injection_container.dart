import 'package:get_it/get_it.dart';
import 'package:weather_app/data/data_sources/weather_remote_data_source_impl.dart';
import 'package:weather_app/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/domain/usecases/get_current_weather_by_name_usecase.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void setupLocator() {
  //bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  //usecase
  locator
      .registerLazySingleton(() => GetCurrentWeatherByNameUseCase(locator()));

  //repository
  locator.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(weatherRemoteDateSource: locator()));

  locator.registerLazySingleton<WeatherRemoteDateSource>(
      () => WeatherRemoteDataSourceImpl(client: locator()));

  locator.registerLazySingleton(() => http.Client());
}
