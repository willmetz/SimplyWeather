import 'package:ost_weather/DataLayer/Location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final String _latitudeKey = "latitude";
  final String _longitudeKey = "longitude";
  final String _locationNameKey = "locationName";
  final String _zoomKey = "zoom";

  static final AppPreferences _instance = AppPreferences._internal();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  factory AppPreferences() {
    return _instance;
  }

  //private constructor to ensure this class is only created here
  AppPreferences._internal();

  Future<bool> saveLocation(Location location) async {
    SharedPreferences sharedPreferences = await _prefs;

    bool savedLatitude = await sharedPreferences.setDouble(_latitudeKey, location.latitude);
    bool savedLongitude = await sharedPreferences.setDouble(_longitudeKey, location.longitude);

    return savedLatitude && savedLongitude;
  }

  Future<Location> getLocation() async {
    SharedPreferences sharedPreferences = await _prefs;

    double long = sharedPreferences.getDouble(_longitudeKey);
    double lat = sharedPreferences.getDouble(_latitudeKey);
s
    if (lat == null && long == null) {
      return null;
    } else {
      return Location.fromGeoInfo(lat, long);
    }
  }

  Future<bool> saveLocationName(String locationName) async {
    SharedPreferences sharedPreferences = await _prefs;

    return await sharedPreferences.setString(_locationNameKey, locationName);
  }

  Future<String> getLocationName() async {
    SharedPreferences sharedPreferences = await _prefs;

    return sharedPreferences.getString(_locationNameKey);
  }

  Future<int> getZoom(int defaultZoom) async {
    SharedPreferences sharedPreferences = await _prefs;

    return sharedPreferences.getInt(_zoomKey) ?? defaultZoom;
  }

  Future<bool> saveZoom(int zoom) async {
    SharedPreferences sharedPreferences = await _prefs;

    return await sharedPreferences.setInt(_zoomKey, zoom);
  }
}
