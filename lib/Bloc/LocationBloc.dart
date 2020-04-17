import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:ost_weather/Bloc/Bloc.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationBloc implements Bloc {
  Location _location;
  Location get selectedLocation => _location;
  final _locationController = StreamController<Location>();
  Stream<Location> get locationStream => _locationController.stream;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Geolocator _geolocator = Geolocator();

  Future<Location> initLocation() async {
    SharedPreferences myPrefs = await _prefs;

    _location = _getLocation(myPrefs);
    _locationController.sink.add(_location);

    return _location;
  }

  Future<bool> updateLocation() async {
    Position position = await _geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);

    if (position != null) {
      SharedPreferences myPrefs = await _prefs;
      Location location = Location.fromGeoInfo(position.latitude, position.longitude);
      _storeLocation(myPrefs, location);
      _locationController.sink.add(location);
    }

    return position != null;
  }

  void selectLocation(Location location) async {
    _location = location;

    SharedPreferences prefs = await _prefs;
    _storeLocation(prefs, location);

    _locationController.sink.add(location);
  }

  void _storeLocation(SharedPreferences sharedPreferences, Location location) {
    sharedPreferences.setInt("zip", location.zipCode);
    sharedPreferences.setDouble("latitude", location.latitude);
    sharedPreferences.setDouble("longitude", location.longitude);
  }

  Location _getLocation(SharedPreferences sharedPreferences) {
    int zip = sharedPreferences.getInt("zip");
    double long = sharedPreferences.getDouble("longitude");
    double lat = sharedPreferences.getDouble("latitude");

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
