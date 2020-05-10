import 'package:ost_weather/DataLayer/Location.dart';

abstract class ILocationService {
  Future<Location> getCurrentLocation();
}
