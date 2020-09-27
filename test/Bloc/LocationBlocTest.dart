import 'package:simply_weather/Bloc/LocationBloc.dart';
import 'package:simply_weather/DataLayer/Location.dart';
import 'package:test/test.dart';

import '../Mocks/MockAppPreferences.dart';
import '../Mocks/MockLocationService.dart';
import '../Mocks/MockWeatherService.dart';

void main() {
  LocationBlocTest blocTest = LocationBlocTest();
  test('Current Location Test', blocTest.testCurrentLocationKnown);
}

class LocationBlocTest {
  MockAppPreferences _mockAppPreferences = new MockAppPreferences();
  MockLocationService _mockLocationService = new MockLocationService();
  MockWeatherService _mockWeatherService = new MockWeatherService();

  void testCurrentLocationKnown() async {
    LocationBloc bloc = LocationBloc(_mockAppPreferences, _mockLocationService, _mockWeatherService);
    _mockAppPreferences.location = Future<Location>.value(Location.fromGeoInfo(12.32, 33.44));
    _mockAppPreferences.locationName = Future<String>.value("Grand Rapids");

    expectLater(
        bloc.locationStream,
        emitsInOrder(List<LocationDataMatcher>.generate(
            2,
            (index) => index == 0
                ? LocationDataMatcher(new LocationData.loading())
                : LocationDataMatcher(LocationData("Grand Rapids")))));

    bloc.initLocation();
  }
}

class LocationDataMatcher extends Matcher {
  final LocationData _expectedData;
  LocationData _actualData;

  LocationDataMatcher(this._expectedData);

  @override
  Description describe(Description description) {
    return description.add("Location Data has expected data");
  }

  @override
  bool matches(actual, Map matchState) {
    _actualData = actual as LocationData;

    bool locationStateMatches = _actualData.locationState() == _expectedData.locationState();
    bool locationNameMatches = _actualData.locationName() == _expectedData.locationName();

    return locationNameMatches && locationStateMatches;
  }
}
