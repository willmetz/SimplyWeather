import 'package:flutter/material.dart';

Widget loading(String text) {
  return Container(
      color: Colors.blue,
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
                style: TextStyle(fontSize: 15),
              ),
            )
          ],
        ),
      ));
}

Widget locationRequired() {
  return Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          "Please set a location to view the weather",
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
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
              "Unable to retrieve weather at this time, please try again.",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: RaisedButton(
                color: Colors.blue[300],
                textColor: Colors.white,
                child: Text("Try Again"),
                onPressed: () => callback(),
              ),
            )
          ],
        ),
      ));
}
