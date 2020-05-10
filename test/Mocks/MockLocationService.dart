import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/Service/LocationService.dart';

class MockLocationService implements LocationService {
  Future<Location> currentLocation;

  @override
  Future<Location> getCurrentLocation() async {
    return await currentLocation;
  }
}
