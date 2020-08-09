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
            _bloc.getLatestRadar(12);
            return Center(
              child: Text("Loading..."),
            );
          } else {
            if (radarData.state == RadarState.noLocationAvailable) {
              return locationRequired();
            }
            return Table(
              border: TableBorder(bottom: BorderSide.none, top: BorderSide.none, left: BorderSide.none, right: BorderSide.none),
              children: [
                TableRow(children: [RadarOverlayWidget(radarData.layeredTiles[0]), RadarOverlayWidget(radarData.layeredTiles[1]), RadarOverlayWidget(radarData.layeredTiles[2])]),
                TableRow(children: [
                  RadarOverlayWidget(radarData.layeredTiles[3]),
                  Stack(children: <Widget>[
                    RadarOverlayWidget(radarData.layeredTiles[4]),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          height: constraints.maxWidth,
                          width: constraints.maxWidth,
                          alignment: Alignment.center,
                          child: CustomPaint(
                              size: Size(constraints.maxWidth, constraints.maxWidth),
                              painter: LocationPainter(radarData.layeredTiles[4].tile.xTileOffsetPercent, radarData.layeredTiles[4].tile.yTileOffsetPercent, Colors.pink)),
                        );
                      },
                    ),
                  ]),
                  RadarOverlayWidget(radarData.layeredTiles[5])
                ]),
                TableRow(children: [RadarOverlayWidget(radarData.layeredTiles[6]), RadarOverlayWidget(radarData.layeredTiles[7]), RadarOverlayWidget(radarData.layeredTiles[8])])
              ],
            );
          }
        },
      )),
    );
  }
}
