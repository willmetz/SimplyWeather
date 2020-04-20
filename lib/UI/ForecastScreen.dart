import 'package:flutter/material.dart';
import 'package:ost_weather/UI/Widgets/DailyForecastDetailsTitleWidget.dart';

import 'Widgets/DailyForecastDetailsCellWidget.dart';

class ForecastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.blue,
      height: 130,
      child: Card(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        color: Colors.blueAccent,
        child: Column(
          children: <Widget>[DailyForecastDetailsTitleWidget(), DailuyForecastDetailsCellWidget()],
        ),
      ),
    ));
  }
}
