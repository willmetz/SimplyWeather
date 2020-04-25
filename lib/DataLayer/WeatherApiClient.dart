import 'dart:convert';
import 'dart:developer';

import 'package:ost_weather/DataLayer/ExtendedForecast.dart';
import 'package:ost_weather/DataLayer/HourlyForecast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/Database/ExtendedForecastDAO.dart';

class WeatherApiClient {
  final _path = "/data/2.5";
  final _host = "api.openweathermap.org";
  final _apiKey = "aa1dc17924497b3c41d3919fc5a27654";

  static final WeatherApiClient _instance = WeatherApiClient._internal();

  factory WeatherApiClient() {
    return _instance;
  }

  //private constructor to ensure this class is only created here
  WeatherApiClient._internal();

  Future<HourlyForecast> getHourlyForecast(String zipcode) async {
    final queryParams = {'zip': '$zipcode', 'APPID': '$_apiKey', 'units': 'imperial'};

    final uri = Uri.https(_host, _path + "/forecast", queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return HourlyForecast.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to get weather: ${response.reasonPhrase}");
    }
  }

  Future<HourlyForecast> getHourlyForecastFromFile() async {
    String weather = await rootBundle.loadString('assets/weather.json');

    return HourlyForecast.fromJson(json.decode(weather));
  }

  Future<ExtendedForecast> getExtendedForecast(Location location) async {
    final queryParams = {'lat': '${location.latitude}', 'lon': '${location.longitude}', 'APPID': '$_apiKey', 'units': 'imperial'};

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
