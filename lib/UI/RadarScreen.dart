import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ost_weather/Bloc/RadarBlock.dart';
import 'package:ost_weather/Bloc/bloc_provider.dart';
import 'package:ost_weather/UI/Widgets/ForecastWidgets.dart';
import 'package:ost_weather/UI/Widgets/LocationPainter.dart';
import 'package:ost_weather/UI/Widgets/RadarOverlayWidget.dart';
import 'package:ost_weather/Utils/AppPreference.dart';

class RadarScreen extends StatelessWidget {
  final RadarBloc _bloc = RadarBloc(AppPreferences());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RadarBloc>(
      bloc: _bloc,
      child: Scaffold(
          body: StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          final RadarData radarData = snapshot.data;

          if (radarData == null) {
            _bloc.getLatestRadar(8);
            return Center(
              child: Text("Loading..."),
            );
          } else {
            if (radarData.state == RadarState.noLocationAvailable) {
              return locationRequired();
            }
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: RadarOverlayWidget(radarData.layeredTiles[0])),
                    Expanded(child: RadarOverlayWidget(radarData.layeredTiles[1])),
                    Expanded(child: RadarOverlayWidget(radarData.layeredTiles[2])),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(child: RadarOverlayWidget(radarData.layeredTiles[3])),
                    Expanded(
                        child: Stack(children: <Widget>[
                      RadarOverlayWidget(radarData.layeredTiles[4]),
                      CustomPaint(painter: LocationPainter(radarData.layeredTiles[4].tile.xTileOffsetPercent, radarData.layeredTiles[4].tile.yTileOffsetPercent, Colors.blue))
                    ])),
                    Expanded(child: RadarOverlayWidget(radarData.layeredTiles[5])),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(child: RadarOverlayWidget(radarData.layeredTiles[6])),
                    Expanded(child: RadarOverlayWidget(radarData.layeredTiles[7])),
                    Expanded(child: RadarOverlayWidget(radarData.layeredTiles[8])),
                  ],
                )
              ],
            );
          }
        },
      )),
    );
  }
}
