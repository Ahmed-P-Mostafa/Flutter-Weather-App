import 'dart:convert';

import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/error/server_exception.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDateSource {
  Future<WeatherModel> getCurrentWeatherByName(String name);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDateSource {
  final http.Client client;
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeatherByName(String name) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName(name)));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    }else {
      throw ServerException ;
    }  
  }
}
