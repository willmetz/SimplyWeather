import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:simply_weather/Bloc/RadarBloc.dart';
import 'package:simply_weather/Images/CacheManagerWithDuration.dart';

class RadarOverlayWidget extends StatelessWidget {
  final MapWithRadarTile _tile;
  final double _height;

  RadarOverlayWidget(this._tile, this._height);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      CachedNetworkImage(
        fadeOutDuration: Duration(seconds: 3),
        imageUrl: _tile.mapUrlForTile,
        fit: BoxFit.scaleDown,
        height: _height,
        cacheManager: CustomCacheManager(Duration(days: 14)),
      ),
      CachedNetworkImage(
          imageUrl: _tile.precipitationUrlForTile,
          fit: BoxFit.scaleDown,
          height: _height,
          cacheManager: CustomCacheManager(Duration(seconds: 5))),
    ]);
  }
}
