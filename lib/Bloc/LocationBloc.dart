import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:ost_weather/Bloc/Bloc.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/Utils/AppPreference.dart';

class LocationBloc implements Bloc {
  Location _location;

  final AppPreferences _appPreferences;

  final _locationController = StreamController<Location>();
  Stream<Location> get locationStream => _locationController.stream;
  Geolocator _geolocator = Geolocator();

  LocationBloc(this._appPreferences);

  void getCurrentLocation(Function(Location) callback) async {
    _location = await _appPreferences.GetLocation();
    if (callback != null) {
      callback(_location);
    }
  }

  void initLocation() async {
    _location = await _appPreferences.GetLocation();
    _locationController.sink.add(_location);
  }

  Future<bool> updateLocation() async {
    Position position = await _geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);

    if (position != null) {
      Location location = Location.fromGeoInfo(position.latitude, position.longitude);
      _appPreferences.SaveLocation(location);
      _locationController.sink.add(location);
    }

    return position != null;
  }

  @override
  void dispose() {
    _locationController.close();
  }
}
