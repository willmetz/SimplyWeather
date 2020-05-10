import 'package:ost_weather/Bloc/LocationBloc.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:test/test.dart';

import '../Mocks/MockAppPreferences.dart';
import '../Mocks/MockLocationService.dart';

void main() {
  LocationBlocTest bloc = LocationBlocTest();
  test('Current Location Test', bloc.testCurrentLocationKnown);
}

class LocationBlocTest {
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
