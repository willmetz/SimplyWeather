import 'package:flutter/material.dart';
import 'package:ost_weather/Bloc/LocationBloc.dart';
import 'package:ost_weather/Bloc/bloc_provider.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/UI/HomeScreen.dart';
import 'package:ost_weather/UI/LocationScreen.dart';

import 'UI/ForecastScreen.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WeatherAppState();
  }
}

class WeatherAppState extends State<WeatherApp> {
  int _bottomNavCurrentIndex = 1;

  @override
  Widget build(BuildContext context) {
    LocationBloc bloc = LocationBloc();

    return MaterialApp(
      title: 'Simply Weather',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<Location>(
        future: bloc.initLocation(),
        builder: (context, snapshot) {
          Location location = snapshot.data;

          return Scaffold(
            appBar: AppBar(title: Text("Simply Weather")),
            bottomNavigationBar: BottomNavigationBar(
              items: getBottomNavBarItems(),
              currentIndex: _bottomNavCurrentIndex,
              onTap: onBottomNavTabTapped,
            ),
            body: getCurrentWidget(_bottomNavCurrentIndex, location),
          );
        },
        //child: MainScreen()),
      ),
    );
  }

  List<BottomNavigationBarItem> getBottomNavBarItems() {
    return [
      new BottomNavigationBarItem(icon: Icon(Icons.edit_location), title: Text("Location")),
      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
      BottomNavigationBarItem(icon: Icon(Icons.calendar_today), title: Text("Forecast"))
    ];
  }

  void onBottomNavTabTapped(int indexTapped) {
    setState(() {
      _bottomNavCurrentIndex = indexTapped;
    });
  }

  getCurrentWidget(int bottomNavCurrentIndex, Location location) {
    switch (bottomNavCurrentIndex) {
      case 0:
        return LocationScreen();
      case 1:
        return HomeScreen(location);
      case 2:
        return ForecastScreen();
    }
  }
}
