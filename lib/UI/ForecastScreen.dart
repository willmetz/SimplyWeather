import 'package:flutter/material.dart';
import 'package:ost_weather/Bloc/ExtendedForecastBloc.dart';
import 'package:ost_weather/Bloc/bloc_provider.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/UI/Widgets/DailyForecastDetailsTitleWidget.dart';

import 'Widgets/DailyForecastDetailsCellWidget.dart';

class ForecastScreen extends StatelessWidget {
  ExtendedForecastBloc _forecastBloc;

  ForecastScreen() {
    _forecastBloc = new ExtendedForecastBloc();
  }

  @override
  StatelessElement createElement() {
    _forecastBloc.GetExtendedForecast(Location(12345));

    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    //_forecastBloc.GetExtendedForecast(Location(21345));

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
