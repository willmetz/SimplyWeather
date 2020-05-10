import 'package:ost_weather/DataLayer/Location.dart';

abstract class IAppPreferences {
  Future<Location> getLocation();
  Future<bool> saveLocation(Location location);
}
