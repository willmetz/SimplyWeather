import 'package:simply_weather/DataLayer/Location.dart';
import 'package:simply_weather/Utils/AppPreference.dart';

class MockAppPreferences implements AppPreferences {
  Future<Location> location;
  Future<bool> saveLocationResult;
  Future<String> locationName;
  Future<int> zoomLevel;
  Future<bool> saveZoomResult;
  Future<bool> saveLocationNameResult;

  @override
  Future<Location> getLocation() async {
    return await location;
  }

  @override
  Future<bool> saveLocation(Location location) async {
    return await saveLocationResult;
  }

  @override
  Future<String> getLocationName() async {
    return await locationName;
  }

  @override
  Future<int> getZoom(int defaultZoom) async {
    return await zoomLevel;
  }

  @override
  Future<bool> saveLocationName(String locationName) async {
    return await saveLocationNameResult;
  }

  @override
  Future<bool> saveZoom(int zoom) async {
    return await saveZoomResult;
  }
}
