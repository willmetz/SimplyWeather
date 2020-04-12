import 'dart:convert';

import 'package:ost_weather/DataLayer/DailyForecast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

class WeatherClient {
  final _path = "/data/2.5";
  final _host = "api.openweathermap.org";
  final _apiKey = "aa1dc17924497b3c41d3919fc5a27654";

  Future<DailyForecast> getForecast(String zipcode) async {
    final queryParams = {'zip': '$zipcode', 'APPID': '$_apiKey', 'units': 'imperial'};

    final uri = Uri.https(_host, _path + "/forecast", queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return DailyForecast.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to get weather: ${response.reasonPhrase}");
    }
  }

  Future<DailyForecast> getForecastFromFile() async {
    String weather = await rootBundle.loadString('assets/weather.json');

    return DailyForecast.fromJson(json.decode(weather));
  }
}
