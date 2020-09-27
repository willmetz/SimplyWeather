import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simply_weather/Bloc/HomeBloc.dart';

class CurrentConditionsWidget extends StatelessWidget {
  final HomeData homeData;

  CurrentConditionsWidget(this.homeData);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
      height: 200,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue[300], width: 2), borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                child: Text(
                                  "${homeData.currentTemperature.toInt()}\u00b0",
                                  style: TextStyle(decorationThickness: 2),
                                )),
                            Container(
                              child: Text("${homeData.currentWindSpeed} mph", style: TextStyle(decorationThickness: 2)),
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: homeData.currentConditionsImageUrl,
                              width: 150,
                              fit: BoxFit.fitWidth,
                            ),
                            Text(
                              homeData.currentConditionsDescription,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Feels Like: ${homeData.feelsLikeTemperature.toInt()}\u00b0",
                      style: TextStyle(fontSize: 18, decorationThickness: 2),
                      textAlign: TextAlign.end,
                    ),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  ),
                  Text(
                    "${homeData.hiForDay.toInt()}\u00b0/${homeData.lowForDay.toInt()}\u00b0",
                    style: TextStyle(decorationThickness: 2, fontSize: 16),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
