import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/domain/entites/weather.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
      cityName: "New York",
      main: "Clouds",
      description: "few clouds",
      iconCode: "o2d",
      temperature: 302.28,
      pressure: 1009,
      humidity: 70);
  test("should be a subclass of weather entity", () async {
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test('should return a valid model from json', () async {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_weather_response.json'),
    );

    //act
    final result = WeatherModel.fromJson(jsonMap);

    //assert
    expect(result, equals(testWeatherModel));
  });

  test('should return a json map containing proper data', () async {
    // arrange

    // act
    final result = testWeatherModel.toJson();
    final expectedJsonMap = {
      'weather': [
        {
          'main': 'Clouds',
          'description': "few clouds",
          'icon': "o2d",
        },
      ],
      'main': {
        'temp': 302.28,
        'pressure': 1009,
        'humidity': 70,
      },
      'name': 'New York',
    };

    //assert
    expect(result, equals(expectedJsonMap));
  });
}
