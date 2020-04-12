import 'package:flutter/material.dart';
import 'package:ost_weather/Bloc/HomeBloc.dart';
import 'package:ost_weather/Bloc/bloc_provider.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/UI/Widgets/CurrentConditionsWidget.dart';

import 'Widgets/HourlyConditionsCell.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = HomeBloc();
    homeBloc.getCurrentWeather(new Location(12345));

    return BlocProvider<HomeBloc>(
        bloc: homeBloc,
        child: Scaffold(
            body: StreamBuilder(
                stream: homeBloc.stream,
                builder: (context, snapshot) {
                  final HomeData results = snapshot.data;

                  if (results == null) {
                    return Center(
                      child: Text("No Data yet, make this prettier"),
                    );
                  }

                  return Column(
                    children: <Widget>[
                      CurrentConditionsWidget(results),
                      Expanded(
                        child: ListView.builder(
                            itemCount: results.forecastWindows.length,
                            itemBuilder: (context, index) {
                              return HourlyConditionsCell(results.forecastWindows[index]);
                            }),
                      )
                    ],
                  );
                })));
  }
}
