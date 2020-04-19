import 'dart:async';

import 'package:ost_weather/Bloc/Bloc.dart';
import 'package:ost_weather/DataLayer/HourlyForecast.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/DataLayer/WeatherClient.dart';

final _imageURLPrefix = "https://openweathermap.org/img/w/";

class HomeBloc implements Bloc {
  final _client = WeatherClient();
  final _controller = StreamController<HomeData>();

  Stream<HomeData> get stream => _controller.stream;

  void getCurrentWeather(Location location) async {
    final HourlyForecast forecast = await _client.getHourlyForecastFromFile();

    //find all forecast details for today
    //final today = DateTime.now();
    final today = DateTime.fromMillisecondsSinceEpoch(forecast.forecastIntervals[0].timeStampUTC * 1000, isUtc: false);

    HomeData homeData = HomeData();
    homeData.forecastWindows = new List<ForecastWindow>();

    //seed hi and low temps
    homeData.hiForDay = -999;
    homeData.lowForDay = 999;
    bool currentWeatherSet = false;
    homeData.city = forecast.locationInformation.cityName;

    forecast.forecastIntervals.forEach((f) {
      //get the forecasted time in local time (given in UTC)
      DateTime ft = DateTime.fromMillisecondsSinceEpoch(f.timeStampUTC * 1000, isUtc: false);

      if (today.day == ft.day) {
        final ForecastWindow fw = ForecastWindow(ft, ft.add(new Duration(hours: 3)), f.weatherReadings.temperatureFarenheit, f.weather[0].imageCode);
        homeData.forecastWindows.add(fw);

        //the first forecast found should be current conditions, set it accordinly if it hasn't been set
        if (!currentWeatherSet) {
          currentWeatherSet = true;
          homeData.currentTemperature = f.weatherReadings.temperatureFarenheit;
          homeData.currentWindSpeed = f.windDetails.windSpeed;

          //the weather details are an arrey, need to look into what multiple of these mean
          homeData.currentConditionsDescription = f.weather[0].description;
          homeData.currentConditionsImageCode = f.weather[0].imageCode;
          homeData.feelsLikeTemperature = f.weatherReadings.feelsLike;
        }

        if (homeData.hiForDay < f.weatherReadings.temperatureFarenheit) {
          homeData.hiForDay = f.weatherReadings.temperatureFarenheit;
        }

        if (homeData.lowForDay > f.weatherReadings.temperatureFarenheit) {
          homeData.lowForDay = f.weatherReadings.temperatureFarenheit;
        }
      }
    });

    _controller.sink.add(homeData);
  }

  @override
  void dispose() {
    _controller.close();
  }
}

class HomeData {
  String city;
  double currentTemperature;
  double hiForDay;
  double lowForDay;
  double currentWindSpeed;
  String currentConditionsDescription;
  String currentConditionsImageCode;
  double feelsLikeTemperature;

  String get currentConditionsImageUrl {
    if (currentConditionsImageCode == null || currentConditionsImageCode == "") {
      return "";
    }

    return _imageURLPrefix + currentConditionsImageCode + ".png";
  }

  List<ForecastWindow> forecastWindows;
}

class ForecastWindow {
  final DateTime windowStartTime;
  final DateTime windowEndTime;
  final double temp;
  final String imageCode;

  String get imageUrl {
    if (imageCode == null || imageCode == "") {
      return "";
    }
    return _imageURLPrefix + imageCode + ".png";
  }

  ForecastWindow(this.windowStartTime, this.windowEndTime, this.temp, this.imageCode);
}
