import 'package:flutter/material.dart';
import 'package:simply_weather/UI/HomeScreen.dart';
import 'package:simply_weather/UI/LocationScreen.dart';
import 'package:simply_weather/UI/RadarScreen.dart';

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
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Simply Weather"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.edit_location),
                onPressed: () {
                  onLocationTapped(context);
                },
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.blue,
            items: getBottomNavBarItems(),
            selectedItemColor: Colors.blue[900],
            currentIndex: _bottomNavCurrentIndex,
            onTap: onBottomNavTabTapped,
          ),
          body: getCurrentWidget(_bottomNavCurrentIndex),
        ),
      ),
      //child: MainScreen()),
    );
  }

  List<BottomNavigationBarItem> getBottomNavBarItems() {
    return [
      new BottomNavigationBarItem(icon: Icon(Icons.satellite), title: Text("Radar")),
      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
      BottomNavigationBarItem(icon: Icon(Icons.calendar_today), title: Text("Forecast"))
    ];
  }

  void onLocationTapped(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen()));
  }

  void onBottomNavTabTapped(int indexTapped) {
    setState(() {
      _bottomNavCurrentIndex = indexTapped;
    });
  }

  getCurrentWidget(int bottomNavCurrentIndex) {
    switch (bottomNavCurrentIndex) {
      case 0:
        return RadarScreen();
      case 1:
        return HomeScreen();
      case 2:
        return ForecastScreen();
    }
  }
}
