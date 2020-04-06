import 'package:flutter/material.dart';
import 'package:ost_weather/Bloc/LocationBloc.dart';
import 'package:ost_weather/Bloc/bloc_provider.dart';
import 'package:ost_weather/UI/MainScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocationBloc bloc = LocationBloc();

    return BlocProvider<LocationBloc>(
        bloc: bloc,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder<bool>(
            future: bloc.initLocation(),
            builder: (context, AsyncSnapshot<bool> snapshot) {
              return MainScreen();
            },
            //child: MainScreen()),
          ),
        ));
  }
}
