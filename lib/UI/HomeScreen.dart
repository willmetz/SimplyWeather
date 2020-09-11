import 'package:flutter/material.dart';
import 'package:simply_weather/Bloc/HomeBloc.dart';
import 'package:simply_weather/Bloc/bloc_provider.dart';
import 'package:simply_weather/DataLayer/WeatherApiClient.dart';
import 'package:simply_weather/Database/ExtendedForecastDAO.dart';
import 'package:simply_weather/Database/WeatherLocaleDAO.dart';
import 'package:simply_weather/Service/LocationService.dart';
import 'package:simply_weather/Service/WeatherService.dart';
import 'package:simply_weather/UI/Widgets/CurrentConditionsWidget.dart';
import 'package:simply_weather/Utils/AppPreference.dart';

import 'Widgets/ForecastWidgets.dart';
import 'Widgets/HourlyConditionsCell.dart';

class HomeScreen extends StatelessWidget {
  final HomeBloc homeBloc = HomeBloc(
      AppPreferences(), WeatherService(WeatherApiClient(), ExtendedForecastDAO(), WeatherLocaleDAO()), LocationService());
  HomeScreen() {
    WidgetsBinding.instance.addPostFrameCallback(_onLayoutDone);
  }

  void _onLayoutDone(_) {
    homeBloc.fetchHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
        bloc: homeBloc,
        child: Scaffold(
            body: StreamBuilder(
                stream: homeBloc.stream,
                initialData: homeBloc.getInitialData(),
                builder: (context, snapshot) {
                  final Home results = snapshot.data;

                  switch (results.homeState) {
                    case HomeState.noLocationAvailable:
                      return locationRequired(context);
                    case HomeState.currentConditionsAvailable:
                      return _showCurrentWeather(results.homeData);
                    case HomeState.errorRetrievingConditions:
                      return errorWithRetry(
                          "Unable to retrieve weather at this time, please try again.", "Try Again", homeBloc.fetchHomeData);
                    case HomeState.init:
                      return _init();
                    case HomeState.gettingLatestWeather:
                      return loading("Retrieving Weather");
                  }
                })));
  }

  Widget _init() {
    return Container(
      color: Colors.blue,
    );
  }

  Widget _showCurrentWeather(HomeData homeData) {
    return Container(
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Center(
                child: Text(
              homeData.city,
              style: TextStyle(fontSize: 25),
            )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: CurrentConditionsWidget(homeData),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: homeData.forecastWindows.length,
                itemBuilder: (context, index) {
                  return HourlyConditionsCell(homeData.forecastWindows[index]);
                }),
          )
        ],
      ),
    );
  }
}
