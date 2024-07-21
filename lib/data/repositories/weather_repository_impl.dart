import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/error/server_exception.dart';
import 'package:weather_app/data/data_sources/weather_remote_data_source_impl.dart';
import 'package:weather_app/domain/entites/weather.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDateSource weatherRemoteDateSource;

  WeatherRepositoryImpl({required this.weatherRemoteDateSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeatherByName(
      String name) async {
    try {
      final result =
          await weatherRemoteDateSource.getCurrentWeatherByName(name);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure("Error Occoured"));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    }
  }
}
