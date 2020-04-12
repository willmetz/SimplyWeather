import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ost_weather/Bloc/HomeBloc.dart';

class HourlyConditionsCell extends StatelessWidget {
  final ForecastWindow _forecastWindow;

  HourlyConditionsCell(this._forecastWindow);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Expanded(flex: 1, child: Center(child: Text("${_forecastWindow.windowStartTime.hour} - ${_forecastWindow.windowEndTime.hour}"))),
          Expanded(flex: 1, child: Center(child: Text("${_forecastWindow.temp}\u00b0"))),
          Expanded(
              flex: 1,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: _forecastWindow.imageUrl,
                  height: 75,
                  width: 75,
                  fit: BoxFit.fitWidth,
                ),
              ))
        ],
      ),
    );
  }
}
