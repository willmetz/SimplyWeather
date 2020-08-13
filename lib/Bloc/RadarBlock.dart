import 'dart:async';

import 'package:ost_weather/Bloc/Bloc.dart';
import 'package:ost_weather/Config/WeatherConfig.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/Utils/AppPreference.dart';
import 'dart:math';

import 'package:ost_weather/Utils/MathUtils.dart';

class RadarBloc implements Bloc {
  final AppPreferences _appPreferences;
  final _controller = StreamController<RadarData>();
  final _zoomController = StreamController<int>();
  RadarData _data;

  Stream<RadarData> get stream => _controller.stream;
  Stream<int> get zoomStream => _zoomController.stream;

  RadarBloc(this._appPreferences) {
    _data = new RadarData();
    _data.state = RadarState.init;
  }

  RadarData currentState() => _data;

  void updateZoom(int zoom) {
    _zoomController.sink.add(zoom);
    getLatestRadar(zoom);
  }

  void getLatestRadar(int zoom) async {
    Location location = await _appPreferences.getLocation();

    if (location != null) {
      Tile centerTile = getCenterTile(zoom, location.latitude, location.longitude);

      //build a tile
      _data.layeredTiles.clear();
      _data.layeredTiles.addAll(generateAllTilesFromCenterTile(centerTile, _data));
      _data.state = RadarState.dataReady;
    } else {
      _data.state = RadarState.noLocationAvailable;
    }

    _controller.sink.add(_data);
  }

  List<MapWithRadarTile> generateAllTilesFromCenterTile(Tile centerTile, RadarData currentData) {
    List<MapWithRadarTile> tiles = new List(9);

    int zoom = centerTile.zoom;

    //the order of the tiles will be upper left to bottom right
    Tile tile = Tile(zoom, centerTile.xTileCoordinate - 1, centerTile.yTileCoordinate - 1);
    tiles[0] = MapWithRadarTile(_createMapTileUrl(zoom, tile), _createTileUrl(zoom, tile), tile);
    tile = Tile(zoom, centerTile.xTileCoordinate, centerTile.yTileCoordinate - 1);
    tiles[1] = MapWithRadarTile(_createMapTileUrl(zoom, tile), _createTileUrl(zoom, tile), tile);
    tile = Tile(zoom, centerTile.xTileCoordinate + 1, centerTile.yTileCoordinate - 1);
    tiles[2] = MapWithRadarTile(_createMapTileUrl(zoom, tile), _createTileUrl(zoom, tile), tile);
    tile = Tile(zoom, centerTile.xTileCoordinate - 1, centerTile.yTileCoordinate);
    tiles[3] = MapWithRadarTile(_createMapTileUrl(zoom, tile), _createTileUrl(zoom, tile), tile);
    tile = Tile(zoom, centerTile.xTileCoordinate, centerTile.yTileCoordinate);
    tiles[4] = MapWithRadarTile(_createMapTileUrl(zoom, tile), _createTileUrl(zoom, tile), tile);
    tile = Tile(zoom, centerTile.xTileCoordinate + 1, centerTile.yTileCoordinate);
    tiles[5] = MapWithRadarTile(_createMapTileUrl(zoom, tile), _createTileUrl(zoom, tile), tile);
    tile = Tile(zoom, centerTile.xTileCoordinate - 1, centerTile.yTileCoordinate + 1);
    tiles[6] = MapWithRadarTile(_createMapTileUrl(zoom, tile), _createTileUrl(zoom, tile), tile);
    tile = Tile(zoom, centerTile.xTileCoordinate, centerTile.yTileCoordinate + 1);
    tiles[7] = MapWithRadarTile(_createMapTileUrl(zoom, tile), _createTileUrl(zoom, tile), tile);
    tile = Tile(zoom, centerTile.xTileCoordinate + 1, centerTile.yTileCoordinate + 1);
    tiles[8] = MapWithRadarTile(_createMapTileUrl(zoom, tile), _createTileUrl(zoom, tile), tile);

    return tiles;
  }

  String _createMapTileUrl(int zoom, Tile tile) {
    return "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/$zoom/${tile.xTileNumber}/${tile.yTileNumber}?access_token=$MAPBOX_API_KEY";
  }

  String _createTileUrl(int zoom, Tile tile) {
    return "https://tile.openweathermap.org/map/precipitation_new/$zoom/${tile.xTileNumber}/${tile.yTileNumber}.png?appid=$OPEN_WEATHER_API_KEY";
  }

  Tile getCenterTile(int zoom, double lat, double long) {
    num n = pow(2, zoom);
    double xTile = (n * ((long + 180.0) / 360.0)).toDouble();

    //ytile = int((1.0 - math.asinh(math.tan(lat_rad)) / math.pi) / 2.0 * n)
    num latInRads = degreesToRads(lat);
    double yTile = ((1.0 - asinh(tan(latInRads)) / pi) / 2.0 * n).toDouble();

    return Tile(zoom, xTile, yTile);
  }

  @override
  void dispose() {
    _controller.close();
    _zoomController.close();
  }
}

enum RadarState { init, fetchingData, noLocationAvailable, dataReady, error }

class RadarData {
  final List<MapWithRadarTile> layeredTiles = new List();
  RadarState state;
  int zoom;
}

class MapWithRadarTile {
  final String precipitationUrlForTile;
  final String mapUrlForTile;
  final Tile tile;

  MapWithRadarTile(this.mapUrlForTile, this.precipitationUrlForTile, this.tile);
}

class Tile {
  final int zoom;
  final double xTileCoordinate, yTileCoordinate;

  Tile(this.zoom, this.xTileCoordinate, this.yTileCoordinate);

  int get xTileNumber {
    return xTileCoordinate.floor();
  }

  int get yTileNumber {
    return yTileCoordinate.floor();
  }

  double get xTileOffsetPercent {
    return xTileCoordinate - xTileCoordinate.floor();
  }

  double get yTileOffsetPercent {
    return yTileCoordinate - yTileCoordinate.floor();
  }
}
