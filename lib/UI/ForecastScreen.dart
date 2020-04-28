import 'package:flutter/material.dart';
import 'package:ost_weather/Bloc/ExtendedForecastBloc.dart';
import 'package:ost_weather/Bloc/bloc_provider.dart';
import 'package:ost_weather/DataLayer/WeatherApiClient.dart';
import 'package:ost_weather/Database/ExtendedForecastDAO.dart';
import 'package:ost_weather/Database/HourlyForecastDAO.dart';
import 'package:ost_weather/Service/WeatherService.dart';
import 'package:ost_weather/UI/Widgets/DailyForecastDetailsTitleWidget.dart';
import 'package:ost_weather/Utils/AppPreference.dart';

import 'Widgets/DailyForecastDetailsCellWidget.dart';

class ForecastScreen extends StatelessWidget {
  final ExtendedForecastBloc _forecastBloc =
      new ExtendedForecastBloc(WeatherService(WeatherApiClient(), ExtendedForecastDAO(), HourlyForecstDAO()), AppPreferences());

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
        builder: (context, snapshot) {
          ExtendedForecastData data = snapshot.data;

          if (data == null) {
            return Container(
              color: Colors.blue,
            );
          }

          return Container(
            color: Colors.blue,
            child: ListView.builder(
                itemCount: data.extendedForecast.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.lightBlue,
                    child: Column(
                      children: <Widget>[
                        DailyForecastDetailsTitleWidget(data.extendedForecast[index]),
                        DailyForecastDetailsCellWidget(data.extendedForecast[index])
                      ],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
