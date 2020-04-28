import 'package:ost_weather/DataLayer/HourlyForecast.dart';
import 'package:sembast/sembast.dart';

import 'WeatherDatabase.dart';

class HourlyForecstDAO {
  static const String FOLDER_NAME = "hourlyForecast";
  static const int HOURLY_FORECAST_KEY = 1;
  final _extendedForecastFolder = intMapStoreFactory.store(FOLDER_NAME);

  Future<Database> get _db async => await WeatherDatabase().getDatabase();

  Future addForecast(HourlyForecast forecast) async {
    var data = forecast.toJson();
    await _extendedForecastFolder.record(HOURLY_FORECAST_KEY).put(await _db, data);
  }

  Future<HourlyForecast> getForecast() async {
    final snapshot = await _extendedForecastFolder.record(HOURLY_FORECAST_KEY).get(await _db);

    if (snapshot != null && snapshot.length > 0) {
      return HourlyForecast.fromJson(snapshot);
    }

    return null;
  }
}
