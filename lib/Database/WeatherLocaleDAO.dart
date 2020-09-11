import 'package:simply_weather/DataLayer/Location.dart';
import 'package:simply_weather/DataLayer/WeatherLocale.dart';
import 'package:sembast/sembast.dart';

import 'WeatherDatabase.dart';

class WeatherLocaleDAO {
  static const String FOLDER_NAME = "weatherLocale";
  static const int WEATHER_LOCALE_KEY = 1;
  final _weatherLocaleFolder = intMapStoreFactory.store(FOLDER_NAME);

  Future<Database> get _db async => await WeatherDatabase().getDatabase();

  Future addWeatherLocale(WeatherLocale locale, Location location) async {
    var data = locale.toJson();
    await _weatherLocaleFolder.record(WEATHER_LOCALE_KEY).put(await _db, data);
  }

  Future<WeatherLocale> getWeatherLocale(Location location) async {
    final snapshot = await _weatherLocaleFolder.record(WEATHER_LOCALE_KEY).get(await _db);

    if (snapshot != null && snapshot.length > 0) {
      return WeatherLocale.fromJson(snapshot);
    }

    return null;
  }

  int getWeatherLocaleKey(Location location) {
    return "${location.latitude.toString()}-${location.longitude.toString()}".hashCode;
  }
}
