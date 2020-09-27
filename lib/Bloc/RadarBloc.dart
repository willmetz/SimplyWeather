import 'dart:async';

import 'package:simply_weather/Bloc/Bloc.dart';
import 'package:simply_weather/Config/WeatherConfig.dart';
import 'package:simply_weather/DataLayer/Location.dart';
import 'package:simply_weather/Service/LocationService.dart';
import 'package:simply_weather/Utils/AppPreference.dart';
import 'dart:math';

import 'package:simply_weather/Utils/MathUtils.dart';

class RadarBloc implements Bloc {
  static const int ZOOM_MAX = 18;
  static const int ZOOM_MIN = 2;

  final AppPreferences _appPreferences;
  final LocationService _locationService;
  final _controller = StreamController<RadarData>();
  final _zoomController = StreamController<int>();
  final defaultZoom = 2;
  RadarData _data;

  Stream<RadarData> get stream => _controller.stream;
  Stream<int> get zoomStream => _zoomController.stream;
  StreamSubscription<Location> _locationEventStream;

  RadarBloc(this._appPreferences, this._locationService) {
    _data = new RadarData();
    _data.state = RadarState.init;

    _locationEventStream = _locationService.locationChangeEventStream.listen((location) {
      if (location != null) {
        getLatestRadar(providedLocation: location);
      }
    });
  }

  RadarData currentState() => _data;

  void fetchPreviousZoom() async {
    int zoom = await _appPreferences.getZoom(defaultZoom);

    if (zoom < ZOOM_MIN) {
      zoom = ZOOM_MIN;
    } else if (zoom > ZOOM_MAX) {
      zoom = ZOOM_MAX;
    }
    _zoomController.sink.add(zoom);
  }

  void updateZoom(int zoom) async {
    await _appPreferences.saveZoom(zoom);
    _zoomController.sink.add(zoom);
    getLatestRadar();
  }

  void getLatestRadar({Location providedLocation}) async {
    if (_controller.isClosed) {
      return;
    }

    Location location = providedLocation;

    if (location == null) {
      location = await _appPreferences.getLocation();
    }

    int zoom = await _appPreferences.getZoom(defaultZoom);

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
    List<MapWithRadarTile> tiles = new List();

    int zoom = centerTile.zoom;

    //the order of the tiles will be upper left to bottom right
    for (int yTileOffset = -1; yTileOffset < 2; yTileOffset++) {
      for (int xTileOffset = -1; xTileOffset < 2; xTileOffset++) {
        Tile tile = Tile(zoom, centerTile.xTileCoordinate + xTileOffset, centerTile.yTileCoordinate + yTileOffset);
        tiles.add(MapWithRadarTile(_createMapTileUrl(zoom, tile), _createTileUrl(zoom, tile), tile));
      }
    }

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
    _locationEventStream?.cancel();
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
