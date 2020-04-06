import 'package:flutter/material.dart';
import 'package:ost_weather/Bloc/LocationBloc.dart';
import 'package:ost_weather/Bloc/bloc_provider.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/UI/LocationScreen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Location>(
      stream: BlocProvider.of<LocationBloc>(context).locationStream,
      builder: (context, snapshot) {
        final location = snapshot.data;

        if (location == null) {
          return LocationScreen();
        }

        return Container(
          decoration: BoxDecoration(color: Colors.blue),
          child: Center(
            child: Text("This will be the weather landing page"),
          ),
        );
      },
    );
  }
}
