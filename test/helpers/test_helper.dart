import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/data_sources/weather_remote_data_source_impl.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/domain/usecases/get_current_weather_by_name_usecase.dart';

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDateSource,
    GetCurrentWeatherByNameUseCase
  ], 
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient),]
)

void main(){

}