import 'package:simply_weather/DataLayer/WeatherLocale.dart';
import 'package:simply_weather/DataLayer/Location.dart';
import 'package:simply_weather/DataLayer/ExtendedForecast.dart';
import 'package:simply_weather/Service/WeatherService.dart';

class MockWeatherService implements WeatherService {
  Future<WeatherLocale> mockLocale;

  @override
  Future<ExtendedForecast> getExtendedForecast(Location location) {
    throw UnimplementedError();
  }

  @override
  Future<WeatherLocale> getWeatherLocale(Location location) async {
    return await mockLocale;
  }
}
