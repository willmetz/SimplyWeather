import 'dart:async';

import 'package:ost_weather/Bloc/Bloc.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/Service/ILocationService.dart';
import 'package:ost_weather/Utils/IAppPreferences.dart';

class LocationBloc implements Bloc {
  Location _location;

  final IAppPreferences _appPreferences;
  final ILocationService _locationService;

  final _locationController = StreamController<Location>();
  Stream<Location> get locationStream => _locationController.stream;

  LocationBloc(this._appPreferences, this._locationService);

  void getCurrentLocation(Function(Location) callback) async {
    _location = await _appPreferences.getLocation();
    if (callback != null) {
      callback(_location);
    }
  }

  void initLocation() async {
    _location = await _appPreferences.getLocation();
    _locationController.sink.add(_location);
  }

  Future<bool> updateLocation() async {
    Location location = await _locationService.getCurrentLocation();

    if (location != null) {
      _appPreferences.saveLocation(location);
      _locationController.sink.add(location);
    }

    return location != null;
  }

  @override
  void dispose() {
    _locationController.close();
  }
}
