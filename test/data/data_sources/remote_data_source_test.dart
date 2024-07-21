import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/error/server_exception.dart';
import 'package:weather_app/data/data_sources/weather_remote_data_source_impl.dart';
import 'package:weather_app/data/models/weather_model.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;
  const testCityName = "New York";

  setUp(() async {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get current weather', () {
    test('should return weather model when the response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
          .thenAnswer((_) async => http.Response(
              readJson('helpers/dummy_data/dummy_weather_response.json'), 200));

      // act
      final result = await weatherRemoteDataSourceImpl
          .getCurrentWeatherByName(testCityName);

      // assert
      expect(result, isA<WeatherModel>());
    });

    test(
        'should throw a server exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
          .thenAnswer((_) async => http.Response('Server Error', 404));

      // act
      
    try {
      await weatherRemoteDataSourceImpl.getCurrentWeatherByName(testCityName);
      fail('Expected a ServerException to be thrown');
    } catch (e) {
      // assert
      expect(e, ServerException);
      
    }
    });


  });
}
