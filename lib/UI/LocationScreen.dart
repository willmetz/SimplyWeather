import 'package:flutter/material.dart';
import 'package:ost_weather/Bloc/LocationBloc.dart';
import 'package:ost_weather/Bloc/bloc_provider.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/DataLayer/WeatherApiClient.dart';
import 'package:ost_weather/Database/ExtendedForecastDAO.dart';
import 'package:ost_weather/Database/WeatherLocaleDAO.dart';
import 'package:ost_weather/Service/LocationService.dart';
import 'package:ost_weather/Service/WeatherService.dart';
import 'package:ost_weather/UI/Widgets/ForecastWidgets.dart';
import 'package:ost_weather/Utils/AppPreference.dart';

class LocationScreen extends StatelessWidget {
  final LocationBloc _locationBloc = LocationBloc(
      AppPreferences(), LocationService(), WeatherService(WeatherApiClient(), ExtendedForecastDAO(), WeatherLocaleDAO()));

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
            appBar: AppBar(title: Text("Location")),
            body: StreamBuilder(
                stream: _locationBloc.locationStream,
                initialData: _locationBloc.initialData,
                builder: (context, snapshot) {
                  LocationData locationData = snapshot.data;

                  return Stack(
                    children: [
                      Container(
                        color: Colors.blue,
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                          Center(
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                  child: RaisedButton(
                                    child: Text("Update Location"),
                                    onPressed: () async {
                                      if (locationData.locationState() != LocationState.Loading) {
                                        await _locationBloc.updateLocation();
                                      }
                                    },
                                  ))),
                          Center(child: currentLocationInformation(locationData)),
                          RaisedButton(child: Text("Done"), onPressed: () => Navigator.pop(context))
                        ]),
                      ),
                      Visibility(
                        child: loading("Updating Location..."),
                        visible: locationData.locationState() == LocationState.Loading,
                      )
                    ],
                  );
                })));
  }

  Widget currentLocationInformation(LocationData locationData) {
    Widget myWidget;

    if (locationData?.locationState() == LocationState.LocationKnown) {
      myWidget = Text("Current location is ${locationData.locationName()}");
    } else {
      myWidget = Text("Location is unknown.");
    }

    return myWidget;
  }
}
