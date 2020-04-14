import 'package:flutter/material.dart';
import 'package:ost_weather/Bloc/LocationBloc.dart';
import 'package:ost_weather/Bloc/bloc_provider.dart';
import 'package:ost_weather/DataLayer/Location.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = LocationBloc();

    return BlocProvider<LocationBloc>(
      bloc: bloc,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: TextField(
              decoration: InputDecoration(border: UnderlineInputBorder(), hintText: "Enter zipcode"),
              keyboardType: TextInputType.number,
              onChanged: (query) {
                Location newLocation = Location(int.parse(query));
                bloc.selectLocation(newLocation);
                print("Made it this far");
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
