import 'dart:async';

import 'package:ost_weather/Bloc/Bloc.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationBloc implements Bloc {
  Location _location;
  Location get selectedLocation => _location;
  final _locationController = StreamController<Location>();
  Stream<Location> get locationStream => _locationController.stream;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> initLocation() async {
    SharedPreferences myPrefs = await _prefs;

    _locationController.sink.add(_getLocation(myPrefs));

    return true;
  }

  void selectLocation(Location location) async {
    _location = location;

    SharedPreferences prefs = await _prefs;
    _storeLocation(prefs, location);

    _locationController.sink.add(location);
  }

  void _storeLocation(SharedPreferences sharedPreferences, Location location) {
    sharedPreferences.setInt("zip", location.zipCode);
    sharedPreferences.setInt("latitude", location.latitude);
    sharedPreferences.setInt("longitude", location.longitude);
  }

  Location _getLocation(SharedPreferences sharedPreferences) {
    int zip = sharedPreferences.getInt("zip");
    int long = sharedPreferences.getInt("longitude");
    int lat = sharedPreferences.getInt("latitude");

    if (zip == null && lat == null && long == null) {
      return null;
    } else {
      return Location.allForms(zip, long, lat);
    }
  }

  @override
  void dispose() {
    _locationController.close();
  }
}
