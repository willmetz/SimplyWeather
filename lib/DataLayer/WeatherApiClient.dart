import 'dart:convert';
import 'dart:developer';

import 'package:simply_weather/Config/WeatherConfig.dart';
import 'package:simply_weather/DataLayer/ExtendedForecast.dart';
import 'package:simply_weather/DataLayer/WeatherLocale.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:simply_weather/DataLayer/Location.dart';

class WeatherApiClient {
  final _path = "/data/2.5";
  final _host = "api.openweathermap.org";

  static final WeatherApiClient _instance = WeatherApiClient._internal();

  factory WeatherApiClient() {
    return _instance;
  }

  //private constructor to ensure this class is only created here
  WeatherApiClient._internal();

  Future<WeatherLocale> getWeatherLocale(Location location) async {
    final queryParams = {
      'lat': '${location.latitude}',
      'lon': '${location.longitude}',
      'APPID': '$OPEN_WEATHER_API_KEY',
      'units': 'imperial'
    };

    final uri = Uri.https(_host, _path + "/forecast", queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return WeatherLocale.fromJson(json.decode(response.body));
    } else {
      log("Failed to get weather: ${response.reasonPhrase}");
    }

    return null;
  }

  Future<WeatherLocale> getLocaleFromFile() async {
    String weather = await rootBundle.loadString('assets/locale.json');

    return WeatherLocale.fromJson(json.decode(weather));
  }

  Future<ExtendedForecast> getExtendedForecast(Location location) async {
    final queryParams = {
      'lat': '${location.latitude}',
      'lon': '${location.longitude}',
      'APPID': '$OPEN_WEATHER_API_KEY',
      'units': 'imperial'
    };

    final uri = Uri.https(_host, _path + "/onecall", queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return ExtendedForecast.fromJson(json.decode(response.body));
    } else {
      log("Failed to get extended forecast: ${response.reasonPhrase}");
      return null;
    }
  }

  Future<ExtendedForecast> getExtendedForecastFromFile() async {
    String weather = await rootBundle.loadString('assets/extendedForecast.json');

    return ExtendedForecast.fromJson(json.decode(weather));
  }
}
