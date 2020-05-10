import 'package:geolocator/geolocator.dart';
import 'package:ost_weather/DataLayer/Location.dart';

import 'ILocationService.dart';

class LocationService implements ILocationService {
  static final LocationService _instance = LocationService._internal();

  factory LocationService() {
    return _instance;
  }

  //private constructor to ensure this class is only created here
  LocationService._internal();

  Geolocator _geolocator = Geolocator();

  @override
  Future<Location> getCurrentLocation() async {
    Position position = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium, locationPermissionLevel: GeolocationPermission.locationWhenInUse);

    if (position != null) {
      return Location.fromGeoInfo(position.latitude, position.longitude);
    }

    return null;
  }
}
