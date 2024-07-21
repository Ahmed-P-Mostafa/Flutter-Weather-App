import 'package:weather_app/domain/usecases/get_current_weather_by_name_usecase.dart';
import 'package:weather_app/presentation/bloc/weather_event.dart';
import 'package:weather_app/presentation/bloc/weather_state.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherByNameUseCase getCurrentWeatherByNameUseCase;
  WeatherBloc(this.getCurrentWeatherByNameUseCase) : super(WeatherEmpty()) {
    on<OnCityChanged>((event, emit) async {
      emit(WeatherLoading());

      final result =
          await getCurrentWeatherByNameUseCase.execute(event.cityName);
      result.fold((failure) {
        emit(WeatherLoadFailure(failure.message));
      }, (data) {
        emit(WeatherLoaded(data));
      });
    },
    transformer: debounce(const Duration(milliseconds: 500))
    );
  }
}

EventTransformer<T> debounce<T> (Duration duration){
  return (events, mapper) => events.debounceTime(duration).flatMap((mapper));
}
