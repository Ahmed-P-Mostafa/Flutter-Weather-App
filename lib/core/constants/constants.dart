import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/domain/entites/weather.dart';

class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'cc95d932d5a45d33a9527d5019475f2c';
  static String currentWeatherByName(String city) =>
      '$baseUrl/weather?q=$city&appid=$apiKey';
  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}

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

const testCityName = "New York";
