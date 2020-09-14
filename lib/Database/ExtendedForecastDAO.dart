import 'package:simply_weather/DataLayer/ExtendedForecast.dart';
import 'package:simply_weather/DataLayer/Location.dart';
import 'package:simply_weather/Database/WeatherDatabase.dart';
import 'package:sembast/sembast.dart';
import 'package:simply_weather/Utils/AppLogger.dart';

class ExtendedForecastDAO {
  static const String FOLDER_NAME = "extendedForecast";
  //static const int FORECAST_KEY = 1;
  final _extendedForecastFolder = intMapStoreFactory.store(FOLDER_NAME);

  Future<Database> get _db async => await WeatherDatabase().getDatabase();

  Future addForecast(ExtendedForecast extendedForecast, Location location) async {
    var data = extendedForecast.toJson();
    await _extendedForecastFolder.record(_forecastKey(location)).put(await _db, data);
  }

  Future<ExtendedForecast> getForecast(Location location) async {
    final snapshot = await _extendedForecastFolder.record(_forecastKey(location)).get(await _db);

    if (snapshot != null && snapshot.length > 0) {
      AppLogger().d("Found extended forecast record for location");
      return ExtendedForecast.fromJson(snapshot);
    } else {
      AppLogger().d("No record found for location, attempting to clearing extended forecast DB");
      Database db = await _db;
      int deletedRecords = await _extendedForecastFolder.delete(db);

      AppLogger().d("Cleared $deletedRecords from DB");
    }

    return null;
  }

  int _forecastKey(Location location) {
    int key = "${location.latitude.toString()}-${location.longitude.toString()}".hashCode;

    return key;
  }
}
