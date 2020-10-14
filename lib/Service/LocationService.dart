import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:simply_weather/DataLayer/Location.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();

  factory LocationService() {
    return _instance;
  }

  //private constructor to ensure this class is only created here
  LocationService._internal();

  // ignore: close_sinks, as the subscribers will close when disposed this is always available
  final _locationChangeEventController = StreamController<Location>.broadcast();
  Stream<Location> get locationChangeEventStream => _locationChangeEventController.stream;

  Future<Location> getCurrentLocation() async {
    try {
      Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.medium)
          .timeout(Duration(seconds: 10))
          .catchError((error) => getLastKnownPosition());

      if (position != null) {
        final location = Location.fromGeoInfo(position.latitude, position.longitude);
        _locationChangeEventController.sink.add(location);
        return location;
      }
    } catch (PlatformException) {}

    return null;
  }
}
