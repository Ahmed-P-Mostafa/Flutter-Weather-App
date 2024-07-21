import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/bloc/weather_event.dart';
import 'package:weather_app/presentation/bloc/weather_state.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherByNameUseCase mockGetCurrentWeatherByNameUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherByNameUseCase = MockGetCurrentWeatherByNameUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherByNameUseCase);
  });

  test("initial state should be empty", () {
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
    "Should retuen [WeatherLoading, WeatherLoaded] when data is gotten successfully",
    build: () {
    when(mockGetCurrentWeatherByNameUseCase.execute(testCityName))
        .thenAnswer((realInvocation) async => const Right(testWeatherModel));
    return weatherBloc;
  },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [WeatherLoading(), const WeatherLoaded(testWeatherModel)]
  );

 blocTest<WeatherBloc, WeatherState>(
    "Should retuen [WeatherLoading, WeatherLoadFailure] when data is gotten unsuccessfully",
    build: () {
    when(mockGetCurrentWeatherByNameUseCase.execute(testCityName))
        .thenAnswer((realInvocation) async => const Left(ServerFailure("Error occoured")));
    return weatherBloc;
  },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [WeatherLoading(), const WeatherLoadFailure("Error occoured")]
  );


}
