import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HourlyConditionsCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(flex: 1, child: Center(child: Text("9PM - 12AM"))),
        Expanded(flex: 1, child: Center(child: Text("low: 60\u00b0\nhi: 65\u00b0"))),
        Expanded(
            flex: 1,
            child: Center(
              child: CachedNetworkImage(
                imageUrl: "http://openweathermap.org/img/w/10d.png",
                height: 75,
                width: 75,
                fit: BoxFit.fitWidth,
              ),
            ))
      ],
    );
  }
}
