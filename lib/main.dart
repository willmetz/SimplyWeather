import 'package:flutter/material.dart';
import 'package:ost_weather/Bloc/LocationBloc.dart';
import 'package:ost_weather/Bloc/bloc_provider.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/UI/HomeScreen.dart';
import 'package:ost_weather/UI/LocationScreen.dart';
import 'package:ost_weather/Utils/AppPreference.dart';

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
    return MaterialApp(
      title: 'Simply Weather',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Simply Weather")),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          items: getBottomNavBarItems(),
          selectedItemColor: Colors.blue[900],
          currentIndex: _bottomNavCurrentIndex,
          onTap: onBottomNavTabTapped,
        ),
        body: getCurrentWidget(_bottomNavCurrentIndex),
      ),
      //child: MainScreen()),
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

  getCurrentWidget(int bottomNavCurrentIndex) {
    switch (bottomNavCurrentIndex) {
      case 0:
        return LocationScreen();
      case 1:
        return HomeScreen();
      case 2:
        return ForecastScreen();
    }
  }
}
