import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ost_weather/Bloc/HomeBloc.dart';

class CurrentConditionsWidget extends StatelessWidget {
  final HomeData homeData;

  CurrentConditionsWidget(this.homeData);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
      height: 200,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 2), borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(padding: EdgeInsets.fromLTRB(0, 0, 0, 5), child: Text("${homeData.currentTemperature}\u00b0")),
                            Container(
                              child: Text("${homeData.currentWindSpeed} mph"),
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            ),
                            Text(homeData.currentConditionsDescription)
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                          child: CachedNetworkImage(
                        imageUrl: homeData.currentConditionsImageUrl,
                        height: 150,
                        width: 150,
                        fit: BoxFit.fitWidth,
                      )),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Feels Like: ${homeData.feelsLikeTemperature}\u00b0",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.end,
                    ),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  ),
                  Text("${homeData.lowForDay}\u00b0/${homeData.hiForDay}\u00b0")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
