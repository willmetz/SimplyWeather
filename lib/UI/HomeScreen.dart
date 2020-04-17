import 'package:flutter/material.dart';
import 'package:ost_weather/Bloc/HomeBloc.dart';
import 'package:ost_weather/Bloc/bloc_provider.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/UI/Widgets/CurrentConditionsWidget.dart';

import 'Widgets/HourlyConditionsCell.dart';

class HomeScreen extends StatelessWidget {
  final Location _location;

  HomeScreen(this._location);

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = HomeBloc();
    homeBloc.getCurrentWeather(_location);

    return BlocProvider<HomeBloc>(
        bloc: homeBloc,
        child: Scaffold(
            body: StreamBuilder(
                stream: homeBloc.stream,
                builder: (context, snapshot) {
                  final HomeData results = snapshot.data;

                  if (results == null) {
                    return Container();
                  }

                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Center(
                            child: Text(
                          results.city,
                          style: TextStyle(fontSize: 25),
                        )),
                      ),
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
