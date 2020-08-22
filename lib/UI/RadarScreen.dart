import 'package:flutter/material.dart';
import 'package:ost_weather/Bloc/RadarBlock.dart';
import 'package:ost_weather/Bloc/bloc_provider.dart';
import 'package:ost_weather/UI/Widgets/ForecastWidgets.dart';
import 'package:ost_weather/UI/Widgets/LocationPainter.dart';
import 'package:ost_weather/UI/Widgets/RadarLegend.dart';
import 'package:ost_weather/UI/Widgets/RadarOverlayWidget.dart';
import 'package:ost_weather/Utils/AppPreference.dart';

class RadarScreen extends StatelessWidget {
  final RadarBloc _bloc = RadarBloc(AppPreferences());
  List<LegendColor> _rainColors, _snowColors;

  RadarScreen() {
    _rainColors = [
      new LegendColor(Color.fromRGBO(200, 150, 150, 1), 0.0007),
      new LegendColor(Color.fromRGBO(200, 150, 150, 1), 0.0014),
      new LegendColor(Color.fromRGBO(120, 120, 190, 1), 0.0035),
      new LegendColor(Color.fromRGBO(110, 110, 205, 0.3), 0.007),
      new LegendColor(Color.fromRGBO(80, 80, 225, 0.7), 0.07),
      new LegendColor(Color.fromRGBO(20, 20, 255, 0.9), 1)
    ];

    _snowColors = [
      new LegendColor(Color.fromRGBO(0, 216, 255, 1), 0.2),
      new LegendColor(Color.fromRGBO(0, 184, 255, 1), 0.4),
      new LegendColor(Color.fromRGBO(149, 73, 255, 1), 1),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double rowHeight = screenWidth / 3;

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
            return Column(
              children: <Widget>[
                Table(
                  border: TableBorder(bottom: BorderSide.none, top: BorderSide.none, left: BorderSide.none, right: BorderSide.none),
                  children: [
                    TableRow(children: [
                      RadarOverlayWidget(radarData.layeredTiles[0], rowHeight),
                      RadarOverlayWidget(radarData.layeredTiles[1], rowHeight),
                      RadarOverlayWidget(radarData.layeredTiles[2], rowHeight),
                    ]),
                    TableRow(children: [
                      RadarOverlayWidget(radarData.layeredTiles[3], rowHeight),
                      Stack(children: <Widget>[
                        RadarOverlayWidget(radarData.layeredTiles[4], rowHeight),
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
                      RadarOverlayWidget(radarData.layeredTiles[5], rowHeight)
                    ]),
                    TableRow(children: [
                      RadarOverlayWidget(radarData.layeredTiles[6], rowHeight),
                      RadarOverlayWidget(radarData.layeredTiles[7], rowHeight),
                      RadarOverlayWidget(radarData.layeredTiles[8], rowHeight)
                    ])
                  ],
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: RadarLegend("Rain", _rainColors, 15),
                        )),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RadarLegend("Snow", _snowColors, 15),
                        )),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: StreamBuilder<int>(
                            stream: _bloc.zoomStream,
                            initialData: 12,
                            builder: (context, snapshot) {
                              int zoom = snapshot.data;
                              return Slider(
                                min: 4,
                                max: 16,
                                value: zoom.toDouble(),
                                divisions: 6,
                                label: zoom.toString(),
                                onChanged: (double value) {
                                  _bloc.updateZoom(value.toInt());
                                },
                              );
                            }),
                      )),
                )
              ],
            );
          }
        },
      )),
    );
  }
}
