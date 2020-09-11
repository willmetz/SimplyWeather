import 'package:flutter/material.dart';
import 'package:simply_weather/Bloc/ExtendedForecastBloc.dart';

class DailyForecastDetailsTitleWidget extends StatelessWidget {
  final DaysForecast _forecast;

  DailyForecastDetailsTitleWidget(this._forecast);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(_forecast.day));
  }
}
