import 'dart:async';

import 'package:ost_weather/Bloc/Bloc.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/DataLayer/WeatherClient.dart';

class ExtendedForecastBloc extends Bloc {
  final _client = WeatherClient();
  final _controller = StreamController<ExtendedForecastData>();

  Stream<ExtendedForecastData> get stream => _controller.stream;

  void GetExtendedForecast(Location location) async {
    ExtendedForecastData extendedForecastData = ExtendedForecastData();

    //TODO - add in logic to call the service and get the extended forecast

    _controller.sink.add(extendedForecastData);
  }

  @override
  void dispose() {
    _controller.close();
  }
}

class ExtendedForecastData {}
