import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/Utils/AppPreference.dart';

class MockAppPreferences implements AppPreferences {
  Future<Location> location;
  Future<bool> saveLocationResult;

  @override
  Future<Location> getLocation() async {
    return await location;
  }

  @override
  Future<bool> saveLocation(Location location) async {
    return await saveLocationResult;
  }
}
