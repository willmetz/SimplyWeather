import 'dart:async';

import 'package:simply_weather/Bloc/Bloc.dart';
import 'package:simply_weather/DataLayer/Location.dart';
import 'package:simply_weather/DataLayer/WeatherLocale.dart';
import 'package:simply_weather/Service/LocationService.dart';
import 'package:simply_weather/Service/WeatherService.dart';
import 'package:simply_weather/Utils/AppLogger.dart';
import 'package:simply_weather/Utils/AppPreference.dart';

class LocationBloc implements Bloc {
  Location _location;

  final AppPreferences _appPreferences;
  final LocationService _locationService;
  final WeatherService _weatherService;
  final LocationData initialData = LocationData.loading();

  final _locationController = StreamController<LocationData>();
  Stream<LocationData> get locationStream => _locationController.stream;

  LocationBloc(this._appPreferences, this._locationService, this._weatherService);

  void initLocation() async {
    _locationController.sink.add(LocationData.loading());

    _location = await _appPreferences.getLocation();

    if (_location != null && _location.hasLocation()) {
      String locationName = await _appPreferences.getLocationName();

      if (locationName != null) {
        LocationData locationData = new LocationData(locationName);
        _locationController.sink.add(locationData);
        return;
      }
    }

    _locationController.sink.add(new LocationData.unknown());
  }

  Future<bool> updateLocation() async {
    AppLogger().d("Updating Location");
    _locationController.sink.add(LocationData.loading());

    Location location = await _locationService.getCurrentLocation();

    if (location != null) {
      _appPreferences.saveLocation(location);

      WeatherLocale locale = await _weatherService.getWeatherLocale(location);

      if (locale != null && locale.locationInformation != null && locale.locationInformation.cityName != null) {
        String city = locale.locationInformation.cityName;
        await _appPreferences.saveLocationName(city);

        _locationController.sink.add(new LocationData(city));
        return true;
      }
    }

    _locationController.sink.add(LocationData.error());
    return false;
  }

  @override
  void dispose() {
    _locationController.close();
  }
}

enum LocationState { LocationUnknown, LocationKnown, Loading, Error }

class LocationData {
  String _locationName;
  LocationState _locationState;

  LocationData(this._locationName) {
    _locationState = LocationState.LocationKnown;
  }

  LocationData.unknown() {
    _locationName = null;
    _locationState = LocationState.LocationUnknown;
  }

  LocationData.loading() {
    _locationName = null;
    _locationState = LocationState.Loading;
  }

  LocationData.error() {
    _locationName = null;
    _locationState = LocationState.Error;
  }

  String locationName() => _locationName;

  LocationState locationState() => _locationState;
}
