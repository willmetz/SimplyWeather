import 'package:ost_weather/DataLayer/ExtendedForecast.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/DataLayer/WeatherApiClient.dart';
import 'package:ost_weather/Database/ExtendedForecastDAO.dart';

class WeatherService {
  static final WeatherService _instance = WeatherService._internal();

  final WeatherApiClient _weatherApiClient;
  final ExtendedForecastDAO _extendedForecastDAO;

  WeatherService._internal(this._extendedForecastDAO, this._weatherApiClient);

  factory WeatherService(WeatherApiClient weatherApiClient, ExtendedForecastDAO extendedForecastDAO) {
    return WeatherService._internal(extendedForecastDAO, weatherApiClient);
  }

  Future<ExtendedForecast> GetExtendedForecast(Location location) async {
    ExtendedForecast extendedForecast = await _extendedForecastDAO.getForecast();

    if (extendedForecast != null) {
      DateTime retrievedAt = DateTime.fromMillisecondsSinceEpoch(extendedForecast.retrievedAtTimeStamp);

      if (retrievedAt.add(Duration(minutes: 15)).isAfter(DateTime.now())) {
        return extendedForecast;
      }

      //cache is either empty or has expired
      extendedForecast = await _weatherApiClient.getExtendedForecast(location);

      if (extendedForecast != null) {
        extendedForecast.retrievedAtTimeStamp = DateTime.now().millisecondsSinceEpoch;

        //save to the db
        await _extendedForecastDAO.addForecast(extendedForecast);
      }

      return extendedForecast;
    }
  }
}
