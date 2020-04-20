import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DailuyForecastDetailsCellWidget extends StatelessWidget {
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
                Container(padding: EdgeInsets.fromLTRB(0, 12, 0, 10), child: Text("Hi Temp: 67\u00b0")),
                Container(padding: EdgeInsets.fromLTRB(0, 10, 0, 12), child: Text("Low Temp: 60\u00b0"))
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text("Wind Speed"), Text("20 mph"), Text("SW")],
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
                    imageUrl: "https://openweathermap.org/img/w/10d.png",
                    height: 75,
                    width: 75,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text("Light Rain"),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
