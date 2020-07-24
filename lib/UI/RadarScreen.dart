import 'package:flutter/material.dart';
import 'package:ost_weather/Bloc/RadarBlock.dart';
import 'package:ost_weather/Bloc/bloc_provider.dart';
import 'package:ost_weather/UI/Widgets/ForecastWidgets.dart';
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
            _bloc.getLatestRadar(4);
            return Center(
              child: Text("Loading..."),
            );
          } else {
            if (radarData.state == RadarState.noLocationAvailable) {
              return locationRequired();
            }
            return Center(
              child: Stack(children: <Widget>[
                Image.network(
                  radarData.layeredTiles[0].mapUrlForTile,
                  height: 256,
                  width: 256,
                ),
                Image.network(
                  radarData.layeredTiles[0].precipitationUrlForTile,
                  height: 256,
                  width: 256,
                ),
              ]),
            );
          }
        },
      )),
    );
  }
}
