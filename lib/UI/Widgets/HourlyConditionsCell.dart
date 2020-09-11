import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simply_weather/Bloc/HomeBloc.dart';

class HourlyConditionsCell extends StatelessWidget {
  final ForecastWindow _forecastWindow;

  HourlyConditionsCell(this._forecastWindow);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.grey[300],
        child: Row(
          children: <Widget>[
            Expanded(flex: 1, child: Center(child: Text("${_forecastWindow.windowStartHour}"))),
            Expanded(flex: 1, child: Center(child: Text("${_forecastWindow.temp.toInt()}\u00b0"))),
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
      ),
    );
  }
}
