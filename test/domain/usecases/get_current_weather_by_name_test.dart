
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';
import 'package:weather_app/domain/entites/weather.dart';
import 'package:weather_app/domain/usecases/get_current_weather_by_name_usecase.dart';



void main() {
  late GetCurrentWeatherByNameUseCase getCurrentWeatherByNameUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
     mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherByNameUseCase =
        GetCurrentWeatherByNameUseCase(mockWeatherRepository);
  });

  const testWeatherDetails = WeatherEntity(
      cityName: "New York", 
      main: "Clouds",
      description: "few clouds",
      iconCode: "o2d",
      temperature: 302.28,
      pressure: 1009,
      humidity: 70);

  const testCityName = "New York";

  test('should get current weather detail from repository', () async {
    //arrange
    when(mockWeatherRepository.getCurrentWeatherByName(testCityName))
        .thenAnswer((_) async => const Right(testWeatherDetails));

    //act
    final result = await getCurrentWeatherByNameUseCase.execute(testCityName);

    // assert
    expect(result, const Right(testWeatherDetails));
  });
  
}
