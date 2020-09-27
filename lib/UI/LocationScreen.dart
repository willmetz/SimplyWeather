import 'package:flutter/material.dart';
import 'package:simply_weather/Bloc/LocationBloc.dart';
import 'package:simply_weather/Bloc/bloc_provider.dart';
import 'package:simply_weather/DataLayer/WeatherApiClient.dart';
import 'package:simply_weather/Database/ExtendedForecastDAO.dart';
import 'package:simply_weather/Database/WeatherLocaleDAO.dart';
import 'package:simply_weather/Service/LocationService.dart';
import 'package:simply_weather/Service/WeatherService.dart';
import 'package:simply_weather/UI/Widgets/ForecastWidgets.dart';
import 'package:simply_weather/Utils/AppPreference.dart';

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
                          Center(child: currentLocationInformation(locationData)),
                          Center(
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
                                  child: RaisedButton(
                                    color: Color.fromRGBO(0, 0x69, 0xC0, 1),
                                    child: Text(
                                      "Update Location",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      if (locationData.locationState() != LocationState.Loading) {
                                        await _locationBloc.updateLocation();
                                      }
                                    },
                                  ))),
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
      myWidget = Text(
        locationData.locationName(),
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      );
    } else {
      myWidget = Text(
        "Location is unknown.",
        style: TextStyle(fontSize: 25, color: Colors.red),
        textAlign: TextAlign.center,
      );
    }

    return myWidget;
  }
}
