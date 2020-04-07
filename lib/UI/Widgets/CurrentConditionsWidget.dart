import 'package:flutter/material.dart';

class CurrentConditionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 2), borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              child: Row(
                children: <Widget>[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[Text("66\u00b0"), Text("10 mph"), Text("Cloudy")],
                    ),
                  ),
                  Center(
                    child: Text("image"),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 50, 0, 0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[Text("Feels Like: ", style: TextStyle(fontSize: 15)), Text("60\u00b0")],
                ),
                Text("50\u00b0/60\u00b0")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
