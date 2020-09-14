import 'package:simply_weather/DataLayer/Location.dart';
import 'package:simply_weather/DataLayer/WeatherLocale.dart';
import 'package:sembast/sembast.dart';
import 'package:simply_weather/Utils/AppLogger.dart';

import 'WeatherDatabase.dart';

class WeatherLocaleDAO {
  static const String FOLDER_NAME = "weatherLocale";
  final _weatherLocaleFolder = intMapStoreFactory.store(FOLDER_NAME);

  Future<Database> get _db async => await WeatherDatabase().getDatabase();

  Future addWeatherLocale(WeatherLocale locale, Location location) async {
    var data = locale.toJson();
    await _weatherLocaleFolder.record(getWeatherLocaleKey(location)).put(await _db, data);
  }

  Future<WeatherLocale> getWeatherLocale(Location location) async {
    final snapshot = await _weatherLocaleFolder.record(getWeatherLocaleKey(location)).get(await _db);

    if (snapshot != null && snapshot.length > 0) {
      AppLogger().d("Found weather locale record for location");
      return WeatherLocale.fromJson(snapshot);
    } else {
      AppLogger().d("No records found for location in weather locale DB, attempting to clear out DB");
      Database db = await _db;
      int deletedRecords = await _weatherLocaleFolder.delete(db);
      AppLogger().d("Deleted $deletedRecords from DB");
    }

    return null;
  }

  int getWeatherLocaleKey(Location location) {
    return "${location.latitude.toString()}-${location.longitude.toString()}".hashCode;
  }
}
