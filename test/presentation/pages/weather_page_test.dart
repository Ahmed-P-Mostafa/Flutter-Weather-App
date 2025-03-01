import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/bloc/weather_event.dart';
import 'package:weather_app/presentation/bloc/weather_state.dart';
import 'package:weather_app/presentation/pages/weather_page.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    HttpOverrides.global = null;
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
        create: (context) => mockWeatherBloc, child: MaterialApp(home: body));
  }

  testWidgets('text field should triger state from loadin to loaded',
      (widgetTester) async {
    //arrange
    when(() => mockWeatherBloc.state).thenReturn(WeatherEmpty());

    //act
    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));
    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await widgetTester.enterText(textField, "New York");
    await widgetTester.pump();
    expect(find.text("New York"), findsOneWidget);
  });

  testWidgets('should show progress indicator when the state is loading',
      (widgetTester) async {
    //arrange
    when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());

    //act
    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

    //assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'should show widget contains weather data when state is weather loaded',
      (widgetTester) async {
    //arrange
    when(() => mockWeatherBloc.state)
        .thenReturn(const WeatherLoaded(testWeatherEntity));

    //act
    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

    expect(find.byKey(const Key('weather_data')), findsOneWidget);
  });
}
