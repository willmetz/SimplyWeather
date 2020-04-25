import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ost_weather/Bloc/LocationBloc.dart';
import 'package:ost_weather/Bloc/bloc_provider.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/Utils/AppPreference.dart';

class LocationScreen extends StatelessWidget {
  LocationBloc _locationBloc;

  LocationScreen() {
    _locationBloc = LocationBloc(AppPreferences());
  }

  @override
  StatelessElement createElement() {
    _locationBloc.initLocation();

    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationBloc>(
        bloc: _locationBloc,
        child: Scaffold(
            body: StreamBuilder(
                stream: _locationBloc.locationStream,
                builder: (context, snapshot) {
                  Location location = snapshot.data;

                  return Column(children: <Widget>[
                    Center(
                        child: Container(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: RaisedButton(
                              child: Text("Update Location"),
                              onPressed: () async {
                                await _locationBloc.updateLocation();
                              },
                            ))),
                    Center(child: currentLocationInformation(location)),
                  ]);
                })));
  }

  Widget currentLocationInformation(Location location) {
    Widget myWidget;

    if (location == null) {
      myWidget = Text("Location required to get weather information.");
    } else {
      myWidget = Text("Current location is known");
    }

    return myWidget;
  }
}
