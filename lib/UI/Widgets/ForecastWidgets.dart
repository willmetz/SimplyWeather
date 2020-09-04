import 'package:flutter/material.dart';

import '../LocationScreen.dart';

Widget loading(String text) {
  return Container(
      color: Color.fromRGBO(40, 44, 52, 0.9),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                backgroundColor: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Text(
                text,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            )
          ],
        ),
      ));
}

Widget locationRequired(BuildContext context) {
  return Container(
      color: Colors.blue,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Please set a location to view the weather",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                FlatButton(
                  child: Text(
                    "Update Location",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen())),
                )
              ],
            ),
          ),
        ],
      ));
}

Widget errorWithRetry(String errorMsg, String retryTxt, Function() callback) {
  return Container(
      color: Colors.blue,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              errorMsg,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: RaisedButton(
                color: Colors.blue[300],
                textColor: Colors.white,
                child: Text(retryTxt),
                onPressed: () => callback(),
              ),
            )
          ],
        ),
      ));
}
