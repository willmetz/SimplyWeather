import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: "Enter zipcode"),
              keyboardType: TextInputType.number,
              onChanged: (query) {
                //TODO
              },
            ),
          ),
          Expanded(
            child: Center(child: Text("Enter Zipcode for location")),
          )
        ],
      ),
    );
  }
}
