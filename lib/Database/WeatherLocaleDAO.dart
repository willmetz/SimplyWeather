import 'package:ost_weather/DataLayer/WeatherLocale.dart';
import 'package:sembast/sembast.dart';

import 'WeatherDatabase.dart';

class WeatherLocaleDAO {
  static const String FOLDER_NAME = "weatherLocale";
  static const int WEATHER_LOCALE_KEY = 1;
  final _weatherLocaleFolder = intMapStoreFactory.store(FOLDER_NAME);

  Future<Database> get _db async => await WeatherDatabase().getDatabase();

  Future addWeatherLocale(WeatherLocale locale) async {
    var data = locale.toJson();
    await _weatherLocaleFolder.record(WEATHER_LOCALE_KEY).put(await _db, data);
  }

  Future<WeatherLocale> getWeatherLocale() async {
    final snapshot = await _weatherLocaleFolder.record(WEATHER_LOCALE_KEY).get(await _db);

    if (snapshot != null && snapshot.length > 0) {
      return WeatherLocale.fromJson(snapshot);
    }

    return null;
  }
}
