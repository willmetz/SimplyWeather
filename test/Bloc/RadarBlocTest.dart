import 'package:simply_weather/Bloc/RadarBloc.dart';
import 'package:simply_weather/DataLayer/Location.dart';
import 'package:test/test.dart';

import '../Mocks/MockAppPreferences.dart';
import '../Mocks/MockLocationService.dart';

void main() {
  RadarBlocTest bloc = RadarBlocTest();
  group("Tile calculations", () {
    test('Test location tile calculated correctly', bloc.testCenterTileCalculation);
    test('Test radar data is streamed correctly', bloc.givenValidLocationThenStreamShouldEmitExpectedRadarData);
  });
}

class RadarBlocTest {
  MockAppPreferences _mockAppPreferences = new MockAppPreferences();
  MockLocationService _mockLocationService = new MockLocationService();

  void testCenterTileCalculation() {
    RadarBloc bloc = RadarBloc(_mockAppPreferences, _mockLocationService);
    _mockAppPreferences.location = Future<Location>.value(Location.fromGeoInfo(41.85, -87.65));

    Tile centerTile = bloc.getCenterTile(12, 41.85, -87.65);

    expect(centerTile.xTileNumber, equals(1050));
    expect(centerTile.yTileNumber, equals(1522));
  }

  void givenValidLocationThenStreamShouldEmitExpectedRadarData() async {
    RadarBloc bloc = RadarBloc(_mockAppPreferences, _mockLocationService);
    _mockAppPreferences.location = Future<Location>.value(Location.fromGeoInfo(41.85, -87.65));
    _mockAppPreferences.zoomLevel = Future<int>.value(12);

    double centerTileX = 1050;
    double centerTileY = 1522;
    int zoom = 12;

    RadarData expectedData = RadarData();

    for (int i = -1; i < 2; i++) {
      Tile tile = Tile(zoom, centerTileX + i, centerTileY - 1);
      expectedData.layeredTiles.add(MapWithRadarTile(
          "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/$zoom/${tile.xTileNumber}/${tile.yTileNumber}",
          "https://tile.openweathermap.org/map/precipitation_new/$zoom/${tile.xTileNumber}/${tile.yTileNumber}.png",
          tile));
    }

    for (int i = -1; i < 2; i++) {
      Tile tile = Tile(zoom, centerTileX + i, centerTileY);
      expectedData.layeredTiles.add(MapWithRadarTile(
          "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/$zoom/${tile.xTileNumber}/${tile.yTileNumber}",
          "https://tile.openweathermap.org/map/precipitation_new/$zoom/${tile.xTileNumber}/${tile.yTileNumber}.png",
          tile));
    }

    for (int i = -1; i < 2; i++) {
      Tile tile = Tile(zoom, centerTileX + i, centerTileY + 1);
      expectedData.layeredTiles.add(MapWithRadarTile(
          "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/$zoom/${tile.xTileNumber}/${tile.yTileNumber}",
          "https://tile.openweathermap.org/map/precipitation_new/$zoom/${tile.xTileNumber}/${tile.yTileNumber}.png",
          tile));
    }
    expectedData.state = RadarState.dataReady;

    expectLater(bloc.stream, emits(RadarDataMatcher(expectedData)));

    bloc.getLatestRadar();
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

    bool tileDataMatches = true;

    for (int i = 0; i < expectedData.layeredTiles.length; i++) {
      tileDataMatches &= actualData.layeredTiles[i].precipitationUrlForTile
          .startsWith(expectedData.layeredTiles[i].precipitationUrlForTile);
      tileDataMatches &= actualData.layeredTiles[i].mapUrlForTile.startsWith(expectedData.layeredTiles[i].mapUrlForTile);
    }

    return tileDataMatches && actualData.state == expectedData.state;
  }

  Description describeMismatch(
      dynamic item, Description mismatchDescription, Map<dynamic, dynamic> matchState, bool verbose) {
    return mismatchDescription.add("Has actual emitted radar data: '$actualData'\nexpected = $expectedData");
  }
}
