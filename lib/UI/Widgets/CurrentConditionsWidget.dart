import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CurrentConditionsWidget extends StatelessWidget {
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
                            Container(padding: EdgeInsets.fromLTRB(0, 0, 0, 5), child: Text("66\u00b0")),
                            Container(
                              child: Text("10 mph"),
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            ),
                            Text("Cloudy")
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                          child: CachedNetworkImage(
                        imageUrl: "http://openweathermap.org/img/w/10d.png",
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
                      "Feels Like: 60\u00b0",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.end,
                    ),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  ),
                  Text("50\u00b0/60\u00b0")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
