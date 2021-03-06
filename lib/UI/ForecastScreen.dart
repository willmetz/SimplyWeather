import 'package:flutter/material.dart';
import 'package:simply_weather/Bloc/ExtendedForecastBloc.dart';
import 'package:simply_weather/Bloc/bloc_provider.dart';
import 'package:simply_weather/DataLayer/WeatherApiClient.dart';
import 'package:simply_weather/Database/ExtendedForecastDAO.dart';
import 'package:simply_weather/Database/WeatherLocaleDAO.dart';
import 'package:simply_weather/Service/LocationService.dart';
import 'package:simply_weather/Service/WeatherService.dart';
import 'package:simply_weather/UI/Widgets/DailyForecastDetailsTitleWidget.dart';
import 'package:simply_weather/Utils/AppPreference.dart';

import 'Widgets/DailyForecastDetailsCellWidget.dart';
import 'Widgets/ForecastWidgets.dart';

class ForecastScreen extends StatelessWidget {
  final ExtendedForecastBloc _forecastBloc = new ExtendedForecastBloc(
      WeatherService(WeatherApiClient(), ExtendedForecastDAO(), WeatherLocaleDAO()), AppPreferences(), LocationService());

  ForecastScreen() {
    WidgetsBinding.instance.addPostFrameCallback(_onLayoutDone);
  }

  void _onLayoutDone(Duration duration) {
    _forecastBloc.getExtendedForecast();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExtendedForecastBloc>(
      bloc: _forecastBloc,
      child: StreamBuilder(
        stream: _forecastBloc.stream,
        initialData: _forecastBloc.getInitialData(),
        builder: (context, snapshot) {
          ExtendedForecastData data = snapshot.data;

          switch (data.extendedForecastState) {
            case ExtendedForecastState.loading:
              return loading("Loading Forecast");
            case ExtendedForecastState.locationRequired:
              return locationRequired(context);
            case ExtendedForecastState.forecastReady:
              return showExtendedForecast(data);
            case ExtendedForecastState.forecastError:
              return errorWithRetry("Error obtaining forecast.", "Try Again", _forecastBloc.getExtendedForecast);
            case ExtendedForecastState.init:
              return Container(
                color: Colors.blue,
              );
          }
        },
      ),
    );
  }

  Widget showExtendedForecast(ExtendedForecastData data) {
    return Container(
      color: Colors.blue,
      child: ListView.builder(
          itemCount: data.extendedForecast.length,
          itemBuilder: (context, index) {
            return Card(
              color: Color.fromRGBO(0, 0x69, 0xC0, 1),
              child: Column(
                children: <Widget>[
                  DailyForecastDetailsTitleWidget(data.extendedForecast[index]),
                  DailyForecastDetailsCellWidget(data.extendedForecast[index])
                ],
              ),
            );
          }),
    );
  }
}
