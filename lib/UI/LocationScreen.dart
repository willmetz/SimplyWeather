import 'package:flutter/material.dart';
import 'package:ost_weather/Bloc/LocationBloc.dart';
import 'package:ost_weather/Bloc/bloc_provider.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/Service/LocationService.dart';
import 'package:ost_weather/Utils/AppPreference.dart';

class LocationScreen extends StatelessWidget {
  final LocationBloc _locationBloc = LocationBloc(AppPreferences(), LocationService());

  LocationScreen() {
    WidgetsBinding.instance.addPostFrameCallback(_onLayoutDone);
  }

  void _onLayoutDone(_) {
    _locationBloc.initLocation();
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

                  return Container(
                    color: Colors.blue,
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
                    ]),
                  );
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
