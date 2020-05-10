import 'package:ost_weather/Bloc/LocationBloc.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/Service/ILocationService.dart';
import 'package:ost_weather/Utils/IAppPreferences.dart';
import 'package:test/test.dart';

void main() {
  LocationBloc_Test bloc = LocationBloc_Test();
  test('Current Location Test', bloc.testCurrentLocationKnown);
}

class LocationBloc_Test {
  MockAppPreferences _mockAppPreferences = new MockAppPreferences();
  MockLocationService _mockLocationService = new MockLocationService();

  void testCurrentLocationKnown() {
    LocationBloc bloc = LocationBloc(_mockAppPreferences, _mockLocationService);
    _mockAppPreferences.location = Future<Location>.value(Location.fromGeoInfo(12.32, 33.44));

    bloc.getCurrentLocation((location) {
      expect(location.latitude, equals(12.32));
      expect(location.longitude, equals(33.44));
    });
  }
}

class MockAppPreferences implements IAppPreferences {
  Future<Location> location;
  Future<bool> saveLocationResult;

  @override
  Future<Location> getLocation() async {
    return await location;
  }

  @override
  Future<bool> saveLocation(Location location) async {
    return await saveLocationResult;
  }
}

class MockLocationService implements ILocationService {
  Future<Location> currentLocation;

  @override
  Future<Location> getCurrentLocation() async {
    return await currentLocation;
  }
}
