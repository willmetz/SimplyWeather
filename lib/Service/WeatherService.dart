import 'package:ost_weather/DataLayer/ExtendedForecast.dart';
import 'package:ost_weather/DataLayer/HourlyForecast.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/DataLayer/WeatherApiClient.dart';
import 'package:ost_weather/Database/ExtendedForecastDAO.dart';
import 'package:ost_weather/Database/HourlyForecastDAO.dart';

class WeatherService {
  static final Map<String, WeatherService> _cache = <String, WeatherService>{};

  final WeatherApiClient _weatherApiClient;
  final ExtendedForecastDAO _extendedForecastDAO;
  final HourlyForecstDAO _hourlyForecstDAO;

  WeatherService._internal(this._extendedForecastDAO, this._weatherApiClient, this._hourlyForecstDAO);

  factory WeatherService(WeatherApiClient weatherApiClient, ExtendedForecastDAO extendedForecastDAO, HourlyForecstDAO hourlyForecstDAO) {
    return _cache.putIfAbsent("WeatherService", () => WeatherService._internal(extendedForecastDAO, weatherApiClient, hourlyForecstDAO));
  }

  Future<ExtendedForecast> getExtendedForecast(Location location) async {
    ExtendedForecast extendedForecast = await _extendedForecastDAO.getForecast();

    if (extendedForecast != null) {
      DateTime retrievedAt = DateTime.fromMillisecondsSinceEpoch(extendedForecast.retrievedAtTimeStamp);

      if (retrievedAt.add(Duration(minutes: 15)).isAfter(DateTime.now())) {
        return extendedForecast;
      }
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

  Future<HourlyForecast> getHourlyForecast(Location location) async {
    HourlyForecast forecast = await _hourlyForecstDAO.getForecast();

    if (HourlyForecast != null) {
      DateTime retrievedAt = DateTime.fromMillisecondsSinceEpoch(forecast.retrievedAtTimeStamp);

      if (retrievedAt != null && retrievedAt.add(Duration(minutes: 15)).isAfter(DateTime.now())) {
        return forecast;
      }
    }

    //cache is empty or expired, retrieve new data
    if (location != null && location.latitude != null && location.longitude != null) {
      forecast = await _weatherApiClient.getHourlyForecast(location);
    }

    return null;
  }
}
