import 'package:flutter/material.dart';

import 'Widgets/DailyForecastDetailsCellWidget.dart';

class ForecastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: DailuyForecastDetailsCellWidget()));
  }
}
