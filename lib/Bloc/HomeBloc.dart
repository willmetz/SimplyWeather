import 'dart:async';

import 'package:ost_weather/Bloc/Bloc.dart';
import 'package:ost_weather/DataLayer/HourlyForecast.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/Service/WeatherService.dart';
import 'package:ost_weather/Utils/AppPreference.dart';
import 'package:ost_weather/Utils/IconUtils.dart';

class HomeBloc implements Bloc {
  final _controller = StreamController<Home>();
  AppPreferences _appPreferences;
  WeatherService _weatherService;

  HomeBloc(AppPreferences appPreferences, WeatherService weatherService) {
    _appPreferences = appPreferences;
    _weatherService = weatherService;
  }

  Stream<Home> get stream => _controller.stream;

  void currentWeather() async {
    Home home = Home();
    Location location = await _getCurrentLocation();

    if (location == null || location.latitude == null || location.longitude == null) {
      home.homeState = HomeState.noLocationAvailable;
      _controller.sink.add(home);
      return;
    }

    HomeData homeData = await _getCurrentWeather(location);

    if (homeData.forecastWindows == null || homeData.forecastWindows.length == 0) {
      home.homeState = HomeState.errorRetrievingConditions;
      _controller.sink.add(home);
      return;
    }

    home.homeState = HomeState.currentConditionsAvailable;
    home.homeData = homeData;
    _controller.sink.add(home);
  }

  Future<HomeData> _getCurrentWeather(Location location) async {
    final HourlyForecast forecast = await _weatherService.getHourlyForecast(location);

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

    return homeData;
  }

  Future<Location> _getCurrentLocation() async {
    return await _appPreferences.GetLocation();
  }

  @override
  void dispose() {
    _controller.close();
  }
}

class Home {
  HomeState homeState;
  HomeData homeData;
}

enum HomeState { checkingLocation, noLocationAvailable, currentConditionsAvailable, errorRetrievingConditions }

class HomeData {
  bool locationUnknown;
  String city;
  double currentTemperature;
  double hiForDay;
  double lowForDay;
  double currentWindSpeed;
  String currentConditionsDescription;
  String currentConditionsImageCode;
  double feelsLikeTemperature;

  String get currentConditionsImageUrl {
    return getImageUrlFromIconCode(currentConditionsImageCode);
  }

  List<ForecastWindow> forecastWindows;
}

class ForecastWindow {
  final DateTime windowStartTime;
  final DateTime windowEndTime;
  final double temp;
  final String imageCode;

  String get imageUrl {
    return getImageUrlFromIconCode(imageCode);
  }

  ForecastWindow(this.windowStartTime, this.windowEndTime, this.temp, this.imageCode);
}
