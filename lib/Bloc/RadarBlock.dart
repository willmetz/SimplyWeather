import 'dart:async';

import 'package:ost_weather/Bloc/Bloc.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/Utils/AppPreference.dart';
import 'dart:math';

class RadarBloc implements Bloc {
  final AppPreferences _appPreferences;
  final _controller = StreamController<RadarData>();
  RadarData _data;

  Stream<RadarData> get stream => _controller.stream;

  RadarBloc(this._appPreferences) {
    _data = new RadarData();
    _data.state = RadarState.init;
  }

  RadarData currentState() => _data;

  void getLatestRadar(int zoom) async {
    Location location = await _appPreferences.getLocation();

    if (location != null) {
      Tile centerTile = getCenterTile(zoom, location.latitude, location.longitude);

      //build a tile
      //TODO - make layer dynamic
      String api_key = "test";
      String tileUrl = "https://tile.openweathermap.org/map/precipitation_new/$zoom/${centerTile.xTileNumber}/${centerTile.yTileNumber}.png?appid=$api_key";
      _data.tiles.clear();
      _data.tiles.add(tileUrl);
      _data.state = RadarState.dataReady;
    } else {
      _data.state = RadarState.noLocationAvailable;
    }

    _controller.sink.add(_data);
  }

  Tile getCenterTile(int zoom, double lat, double long) {
    num n = pow(2, zoom);
    int xTile = (n * ((long + 180.0) / 360.0)).toInt();

    //ytile = int((1.0 - math.asinh(math.tan(lat_rad)) / math.pi) / 2.0 * n)
    num latInRads = degreesToRads(lat);
    int yTile = ((1.0 - asinh(tan(latInRads)) / pi) / 2.0 * n).toInt();

    return Tile(zoom, xTile, yTile);
  }

  num degreesToRads(num deg) {
    return (deg * pi) / 180.0;
  }

  double asinh(double value) {
    //credit from: https://pub.dev/documentation/dart_numerics/latest/dart_numerics/asinh.html
    if (value.abs() >= 268435456.0) // 2^28, taken from freeBSD
      return value.sign * (log(value.abs()) + log(2.0));

    return value.sign * log(value.abs() + sqrt((value * value) + 1));
  }

  @override
  void dispose() {
    _controller.close();
  }
}

enum RadarState { init, fetchingData, noLocationAvailable, dataReady, error }

class RadarData {
  final List<String> tiles = new List();
  RadarState state;
}

class Tile {
  final int zoom, xTileNumber, yTileNumber;

  Tile(this.zoom, this.xTileNumber, this.yTileNumber);
}
