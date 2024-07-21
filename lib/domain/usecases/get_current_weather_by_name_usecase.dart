import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/domain/entites/weather.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

class GetCurrentWeatherByNameUseCase {
  final WeatherRepository weatherRepository;
  const GetCurrentWeatherByNameUseCase(this.weatherRepository);

  Future<Either<Failure, WeatherEntity>> execute(String cityName) {
    return weatherRepository.getCurrentWeatherByName(cityName);
  }
  
}
