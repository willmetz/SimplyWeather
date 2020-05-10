import 'package:ost_weather/DataLayer/Location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final AppPreferences _instance = AppPreferences._internal();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  factory AppPreferences() {
    return _instance;
  }

  //private constructor to ensure this class is only created here
  AppPreferences._internal();

  Future<bool> saveLocation(Location location) async {
    SharedPreferences sharedPreferences = await _prefs;

    sharedPreferences.setInt("zip", location.zipCode);
    sharedPreferences.setDouble("latitude", location.latitude);
    sharedPreferences.setDouble("longitude", location.longitude);
  }

  Future<Location> getLocation() async {
    SharedPreferences sharedPreferences = await _prefs;

    int zip = sharedPreferences.getInt("zip");
    double long = sharedPreferences.getDouble("longitude");
    double lat = sharedPreferences.getDouble("latitude");

    if (zip == null && lat == null && long == null) {
      return null;
    } else {
      return Location.allForms(zip, long, lat);
    }
  }
}
