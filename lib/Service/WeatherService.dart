import 'package:simply_weather/DataLayer/ExtendedForecast.dart';
import 'package:simply_weather/DataLayer/WeatherLocale.dart';
import 'package:simply_weather/DataLayer/Location.dart';
import 'package:simply_weather/DataLayer/WeatherApiClient.dart';
import 'package:simply_weather/Database/ExtendedForecastDAO.dart';
import 'package:simply_weather/Database/WeatherLocaleDAO.dart';
import 'package:simply_weather/Utils/AppLogger.dart';

class WeatherService {
  static final Map<String, WeatherService> _cache = <String, WeatherService>{};

  final WeatherApiClient _weatherApiClient;
  final ExtendedForecastDAO _extendedForecastDAO;
  final WeatherLocaleDAO _weatherLocaleDAO;
  bool _extendedForecastRequestInProgress;
  bool _localeRequestInProgress;

  WeatherService._internal(this._extendedForecastDAO, this._weatherApiClient, this._weatherLocaleDAO) {
    _extendedForecastRequestInProgress = false;
    _localeRequestInProgress = false;
  }

  factory WeatherService(
      WeatherApiClient weatherApiClient, ExtendedForecastDAO extendedForecastDAO, WeatherLocaleDAO hourlyForecstDAO) {
    return _cache.putIfAbsent(
        "WeatherService", () => WeatherService._internal(extendedForecastDAO, weatherApiClient, hourlyForecstDAO));
  }

  Future<ExtendedForecast> getExtendedForecast(Location location) async {
    int loopLimit = 50;
    while (loopLimit > 0 && _extendedForecastRequestInProgress) {
      AppLogger().d("Extended forecast request in progress, awaiting completion");
      loopLimit--;
      await Future.delayed(Duration(milliseconds: 100));
    }

    _extendedForecastRequestInProgress = true;

    ExtendedForecast extendedForecast = await _extendedForecastDAO.getForecast(location);

    if (extendedForecast != null) {
      DateTime retrievedAt = DateTime.fromMillisecondsSinceEpoch(extendedForecast.retrievedAtTimeStamp);

      if (retrievedAt.add(Duration(minutes: 30)).isAfter(DateTime.now())) {
        _extendedForecastRequestInProgress = false;
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

    _extendedForecastRequestInProgress = false;

    return extendedForecast;
  }

  Future<WeatherLocale> getWeatherLocale(Location location) async {
    int loopLimit = 50;
    while (loopLimit > 0 && _localeRequestInProgress) {
      AppLogger().d("Locale Request in progress, awaiting completion");
      loopLimit--;
      await Future.delayed(Duration(milliseconds: 100));
    }
    _localeRequestInProgress = true;

    WeatherLocale locale = await _weatherLocaleDAO.getWeatherLocale(location);

    if (locale != null && locale.retrievedAtTimeStamp != null) {
      AppLogger().d("Found locale for location in DB");
      DateTime retrievedAt = DateTime.fromMillisecondsSinceEpoch(locale.retrievedAtTimeStamp);

      if (retrievedAt != null && retrievedAt.add(Duration(hours: 5)).isAfter(DateTime.now())) {
        AppLogger().d("Locale not expired");
        _localeRequestInProgress = false;
        return locale;
      }
    }

    //cache is empty or expired, retrieve new data
    if (location != null && location.latitude != null && location.longitude != null) {
      AppLogger().d("Locale not available in DB, attempting to get locale via API");
      locale = await _weatherApiClient.getWeatherLocale(location);
    }

    if (locale != null) {
      locale.retrievedAtTimeStamp = DateTime.now().millisecondsSinceEpoch;

      AppLogger().d("Locale successfully retrieved, saving to DB");
      //save to the db
      await _weatherLocaleDAO.addWeatherLocale(locale, location);
    }

    _localeRequestInProgress = false;
    return locale;
  }
}
