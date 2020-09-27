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
        color: Color.fromRGBO(0, 0x69, 0xC0, 1),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                  "${_forecastWindow.windowStartHour}",
                  style: TextStyle(fontSize: 18, decorationThickness: 2, color: Colors.white),
                ))),
            Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                  "${_forecastWindow.temp.toInt()}\u00b0",
                  style: TextStyle(fontSize: 20, decorationThickness: 2, color: Colors.white),
                ))),
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
