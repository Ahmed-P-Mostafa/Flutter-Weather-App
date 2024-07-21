import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/entites/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  @override
  List<Object?> get props => [];
}

class WeatherLoading extends WeatherState {}

class WeatherEmpty extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity entity;
  const WeatherLoaded(this.entity);

  @override
  List<Object?> get props => [entity];
}

class WeatherLoadFailure extends WeatherState {
  final String message;
  const WeatherLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
