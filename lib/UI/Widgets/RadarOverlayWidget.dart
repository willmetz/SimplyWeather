import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ost_weather/Bloc/RadarBlock.dart';

class RadarOverlayWidget extends StatelessWidget {
  final MapWithRadarTile _tile;

  RadarOverlayWidget(this._tile);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      CachedNetworkImage(
        imageUrl: _tile.mapUrlForTile,
        fit: BoxFit.scaleDown,
      ),
      Image.network(
        _tile.precipitationUrlForTile,
        fit: BoxFit.scaleDown,
      ),
    ]);
  }
}
