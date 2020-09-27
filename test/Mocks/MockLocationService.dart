import 'dart:async';

import 'package:simply_weather/DataLayer/Location.dart';
import 'package:simply_weather/Service/LocationService.dart';

class MockLocationService implements LocationService {
  Future<Location> currentLocation;

  @override
  Future<Location> getCurrentLocation() async {
    return await currentLocation;
  }

  @override
  Stream<Location> get locationChangeEventStream => StreamController<Location>.broadcast().stream;
}
