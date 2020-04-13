import 'package:flutter/material.dart';
import 'package:ost_weather/Bloc/LocationBloc.dart';
import 'package:ost_weather/Bloc/bloc_provider.dart';
import 'package:ost_weather/UI/HomeScreen.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WeatherAppState();
  }
}

class WeatherAppState extends State<WeatherApp> {
  BottomNavigationBar _bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    _bottomNavigationBar = getBottomNavBar();
    LocationBloc bloc = LocationBloc();

    return BlocProvider<LocationBloc>(
        bloc: bloc,
        child: MaterialApp(
          title: 'Simply Weather',
          theme: ThemeData(
            // This is the theme of your application.
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder<bool>(
            future: bloc.initLocation(),
            builder: (context, AsyncSnapshot<bool> snapshot) {
              //TODO - set current index based on if location is already set or not

              return Scaffold(
                bottomNavigationBar: _bottomNavigationBar,
                body: HomeScreen(),
              );
            },
            //child: MainScreen()),
          ),
        ));
    ;
  }

  BottomNavigationBar getBottomNavBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.edit_location), title: Text("Location")),
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), title: Text("Forecast"))
      ],
    );
  }
}
