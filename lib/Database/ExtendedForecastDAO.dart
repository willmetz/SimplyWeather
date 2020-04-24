import 'package:ost_weather/DataLayer/ExtendedForecast.dart';
import 'package:ost_weather/Database/WeatherDatabase.dart';
import 'package:sembast/sembast.dart';

class ExtendedForecastDAO {
  static const String FOLDER_NAME = "extendedForecast";
  static const int FORECAST_KEY = 1234;
  final _extendedForecastFolder = intMapStoreFactory.store(FOLDER_NAME);

  Future<Database> get _db async => await WeatherDatabase().getDatabase();

  Future addForecast(ExtendedForecast extendedForecast) async {
    await _extendedForecastFolder.record(FORECAST_KEY).put(await _db, extendedForecast.toJson());
  }

  Future<ExtendedForecast> getForecast() async {
    final snapshot = await _extendedForecastFolder.record(FORECAST_KEY).get(await _db);

    if (snapshot != null && snapshot.length > 0) {
      return ExtendedForecast.fromJson(snapshot);
    }

    return null;
  }
}
