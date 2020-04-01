import 'dart:async';

import 'package:ost_weather/Bloc/Bloc.dart';
import 'package:ost_weather/DataLayer/Location.dart';

class LocationBloc implements Bloc {
  Location _location;
  Location get selectedLocation => _location;

  final _locationController = StreamController<Location>();
  Stream<Location> get locationStream => _locationController.stream;

  void selectLocation(Location location) {
    _location = location;
    _locationController.sink.add(location);
  }

  @override
  void dispose() {
    _locationController.close();
  }
}
