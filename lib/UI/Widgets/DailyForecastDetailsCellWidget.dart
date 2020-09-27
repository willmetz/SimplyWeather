import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simply_weather/Bloc/ExtendedForecastBloc.dart';

class DailyForecastDetailsCellWidget extends StatelessWidget {
  final DaysForecast _forecast;

  DailyForecastDetailsCellWidget(this._forecast);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 10),
                    child: Text("Hi Temp: ${_forecast.highTemp}\u00b0", style: TextStyle(color: Colors.white))),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 12),
                    child: Text("Low Temp: ${_forecast.lowTemp}\u00b0", style: TextStyle(color: Colors.white)))
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Wind Speed",
                  style: TextStyle(color: Colors.white),
                ),
                Text("${_forecast.windSpeed} mph", style: TextStyle(color: Colors.white)),
                Text(_forecast.windDirection, style: TextStyle(color: Colors.white))
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: CachedNetworkImage(
                    imageUrl: _forecast.imageUrl,
                    height: 75,
                    width: 75,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(_forecast.weatherDescription, style: TextStyle(color: Colors.white)),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
