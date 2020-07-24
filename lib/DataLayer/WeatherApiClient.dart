import 'dart:convert';
import 'dart:developer';

import 'package:ost_weather/Config/WeatherConfig.dart';
import 'package:ost_weather/DataLayer/ExtendedForecast.dart';
import 'package:ost_weather/DataLayer/HourlyForecast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:ost_weather/DataLayer/Location.dart';

class WeatherApiClient {
  final _path = "/data/2.5";
  final _host = "api.openweathermap.org";

  static final WeatherApiClient _instance = WeatherApiClient._internal();

  factory WeatherApiClient() {
    return _instance;
  }

  //private constructor to ensure this class is only created here
  WeatherApiClient._internal();

  Future<HourlyForecast> getHourlyForecast(Location location) async {
    final queryParams = {'lat': '${location.latitude}', 'lon': '${location.longitude}', 'APPID': '$OPEN_WEATHER_API_KEY', 'units': 'imperial'};

    final uri = Uri.https(_host, _path + "/forecast", queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return HourlyForecast.fromJson(json.decode(response.body));
    } else {
      log("Failed to get weather: ${response.reasonPhrase}");
    }

    return null;
  }

  Future<HourlyForecast> getHourlyForecastFromFile() async {
    String weather = await rootBundle.loadString('assets/weather.json');

    return HourlyForecast.fromJson(json.decode(weather));
  }

  Future<ExtendedForecast> getExtendedForecast(Location location) async {
    final queryParams = {'lat': '${location.latitude}', 'lon': '${location.longitude}', 'APPID': '$OPEN_WEATHER_API_KEY', 'units': 'imperial'};

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
