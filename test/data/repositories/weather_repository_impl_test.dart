import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/error/server_exception.dart';
import 'package:weather_app/data/data_sources/weather_remote_data_source_impl.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/domain/entites/weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late WeatherRepositoryImpl weatherRepositoryImpl;
  late WeatherRemoteDateSource weatherRemoteDataSource;

  setUp(() {
    weatherRemoteDataSource = MockWeatherRemoteDateSource();
    weatherRepositoryImpl =
        WeatherRepositoryImpl(weatherRemoteDateSource: weatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
      cityName: "New York",
      main: "Clouds",
      description: "few clouds",
      iconCode: "o2d",
      temperature: 302.28,
      pressure: 1009,
      humidity: 70);

  const testWeatherEntity = WeatherEntity(
      cityName: "New York",
      main: "Clouds",
      description: "few clouds",
      iconCode: "o2d",
      temperature: 302.28,
      pressure: 1009,
      humidity: 70);

  group("get current weather", () {
    final testCityName = "New York";
    test(
        'should return a current weather if the call to the data source is successful',
        () async {
      // arrange
      when(weatherRemoteDataSource.getCurrentWeatherByName(testCityName))
          .thenAnswer((realInvocation) async => testWeatherModel);

      //act
      final result =
          await weatherRepositoryImpl.getCurrentWeatherByName(testCityName);

      //assert
      expect(result,equals(const Right(testWeatherEntity)));
    });

     test(
        'should return a server failure when the call to the data source is unsuccessful',
        () async {
      // arrange
      when(weatherRemoteDataSource.getCurrentWeatherByName(testCityName))
          .thenThrow(ServerException() );

      //act
      final result =
          await weatherRepositoryImpl.getCurrentWeatherByName(testCityName);

      //assert
      expect(result, equals(const Left(ServerFailure("Error Occoured"))));
    });

    test(
        'should return a connection failure when the device has no internet',
        () async {
      // arrange
      when(weatherRemoteDataSource.getCurrentWeatherByName(testCityName))
          .thenThrow(const SocketException("Failed to connect to the network") );

      //act
      final result =
          await weatherRepositoryImpl.getCurrentWeatherByName(testCityName);

      //assert
      expect(result, equals(const Left(ConnectionFailure("Failed to connect to the network"))));
    });


  });
}
