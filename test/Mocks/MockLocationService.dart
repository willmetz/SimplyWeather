import 'package:simply_weather/DataLayer/Location.dart';
import 'package:simply_weather/Service/LocationService.dart';

class MockLocationService implements LocationService {
  Future<Location> currentLocation;

  @override
  Future<Location> getCurrentLocation() async {
    return await currentLocation;
  }

  @override
  // TODO: implement locationChangeEventStream
  Stream<Location> get locationChangeEventStream => throw UnimplementedError();
}
