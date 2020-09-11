import 'package:simply_weather/DataLayer/ExtendedForecast.dart';
import 'package:simply_weather/DataLayer/WeatherLocale.dart';
import 'package:simply_weather/DataLayer/Location.dart';
import 'package:simply_weather/DataLayer/WeatherApiClient.dart';
import 'package:simply_weather/Database/ExtendedForecastDAO.dart';
import 'package:simply_weather/Database/WeatherLocaleDAO.dart';

class WeatherService {
  static final Map<String, WeatherService> _cache = <String, WeatherService>{};

  final WeatherApiClient _weatherApiClient;
  final ExtendedForecastDAO _extendedForecastDAO;
  final WeatherLocaleDAO _weatherLocaleDAO;

  WeatherService._internal(this._extendedForecastDAO, this._weatherApiClient, this._weatherLocaleDAO);

  factory WeatherService(
      WeatherApiClient weatherApiClient, ExtendedForecastDAO extendedForecastDAO, WeatherLocaleDAO hourlyForecstDAO) {
    return _cache.putIfAbsent(
        "WeatherService", () => WeatherService._internal(extendedForecastDAO, weatherApiClient, hourlyForecstDAO));
  }

  Future<ExtendedForecast> getExtendedForecast(Location location) async {
    ExtendedForecast extendedForecast = await _extendedForecastDAO.getForecast(location);

    if (extendedForecast != null) {
      DateTime retrievedAt = DateTime.fromMillisecondsSinceEpoch(extendedForecast.retrievedAtTimeStamp);

      if (retrievedAt.add(Duration(minutes: 30)).isAfter(DateTime.now())) {
        return extendedForecast;
      }
    }

    //cache is either empty or has expired
    extendedForecast = await _weatherApiClient.getExtendedForecast(location);

    if (extendedForecast != null) {
      extendedForecast.retrievedAtTimeStamp = DateTime.now().millisecondsSinceEpoch;

      //save to the db
      await _extendedForecastDAO.addForecast(extendedForecast, location);
    }

    return extendedForecast;
  }

  Future<WeatherLocale> getWeatherLocale(Location location) async {
    WeatherLocale locale = await _weatherLocaleDAO.getWeatherLocale(location);

    if (locale != null && locale.retrievedAtTimeStamp != null) {
      DateTime retrievedAt = DateTime.fromMillisecondsSinceEpoch(locale.retrievedAtTimeStamp);

      if (retrievedAt != null && retrievedAt.add(Duration(minutes: 15)).isAfter(DateTime.now())) {
        return locale;
      }
    }

    //cache is empty or expired, retrieve new data
    if (location != null && location.latitude != null && location.longitude != null) {
      locale = await _weatherApiClient.getWeatherLocale(location);
    }

    if (locale != null) {
      locale.retrievedAtTimeStamp = DateTime.now().millisecondsSinceEpoch;

      //save to the db
      await _weatherLocaleDAO.addWeatherLocale(locale, location);
    }

    return locale;
  }
}
