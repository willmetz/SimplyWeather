import 'package:ost_weather/Bloc/RadarBlock.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:test/test.dart';

import '../Mocks/MockAppPreferences.dart';

void main() {
  RadarBlocTest bloc = RadarBlocTest();
  group("Tile calculations", () {
    test('Test location tile calculated correctly', bloc.testCenterTileCalculation);
    test('Test radar data is streamed correctly', bloc.givenValidLocationThenStreamShouldEmitExpectedRadarData);
  });
}

class RadarBlocTest {
  MockAppPreferences _mockAppPreferences = new MockAppPreferences();

  void testCenterTileCalculation() {
    RadarBloc bloc = RadarBloc(
      _mockAppPreferences,
    );
    _mockAppPreferences.location = Future<Location>.value(Location.fromGeoInfo(41.85, -87.65));

    Tile centerTile = bloc.getCenterTile(12, 41.85, -87.65);

    expect(centerTile.xTileNumber, equals(1050));
    expect(centerTile.yTileNumber, equals(1522));
  }

  void givenValidLocationThenStreamShouldEmitExpectedRadarData() async {
    RadarBloc bloc = RadarBloc(
      _mockAppPreferences,
    );
    _mockAppPreferences.location = Future<Location>.value(Location.fromGeoInfo(41.85, -87.65));

    RadarData expectedData = RadarData();
    expectedData.tiles.add("https://tile.openweathermap.org/map/precipitation_new/12/1050/1522.png?appid=test");

    expectLater(bloc.stream, emits(RadarDataMatcher(expectedData)));

    bloc.getLatestRadar(12);
  }
}

class RadarDataMatcher extends Matcher {
  final RadarData expectedData;
  RadarData actualData;

  RadarDataMatcher(this.expectedData);

  @override
  Description describe(Description description) {
    return description.add("Has expected radar content");
  }

  @override
  bool matches(actual, Map matchState) {
    actualData = actual as RadarData;

    return actualData.tiles[0] == expectedData.tiles[0] && actualData.state == RadarState.dataReady;
  }

  Description describeMismatch(dynamic item, Description mismatchDescription, Map<dynamic, dynamic> matchState, bool verbose) {
    return mismatchDescription
        .add("Has actual emitted radar data: state = '${actualData.state}'\nexpectedState = ${expectedData.state}\nactualState: ${actualData.tiles[0]}\nexpected Tile: ${expectedData.tiles[0]}");
  }
}
