import 'dart:async';

import 'package:intl/intl.dart';
import 'package:ost_weather/Bloc/Bloc.dart';
import 'package:ost_weather/DataLayer/ExtendedForecast.dart';
import 'package:ost_weather/DataLayer/WeatherLocale.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/Service/LocationService.dart';
import 'package:ost_weather/Service/WeatherService.dart';
import 'package:ost_weather/Utils/AppPreference.dart';
import 'package:ost_weather/Utils/IconUtils.dart';

class HomeBloc implements Bloc {
  final _controller = StreamController<Home>();
  AppPreferences _appPreferences;
  WeatherService _weatherService;
  LocationService _locationService;
  StreamSubscription<Location> _locationEventStream;

  HomeBloc(AppPreferences appPreferences, WeatherService weatherService, LocationService locationService) {
    _appPreferences = appPreferences;
    _weatherService = weatherService;
    _locationService = locationService;

    _locationEventStream = _locationService.locationChangeEventStream.listen((location) {
      if (location != null) {
        fetchHomeData(providedLocation: location);
      }
    });
  }

  Stream<Home> get stream => _controller.stream;

  Home getInitialData() {
    Home data = Home();
    data.homeState = HomeState.init;

    return data;
  }

  /*
   * Retrieves the home data either based on the location passed in
   * or based on the location available.
   * 
   * @param: providedLocation - optionally provided location
   */
  void fetchHomeData({Location providedLocation}) async {
    Home home = Home();
    Location location = providedLocation;

    if (location == null) {
      location = await _getCurrentLocation();
    }

    if (location == null || location.latitude == null || location.longitude == null) {
      home.homeState = HomeState.noLocationAvailable;
      _controller.sink.add(home);
      return;
    }

    String cityName = await _getCityName(location);
    final ExtendedForecast extendedForecast = await _weatherService.getExtendedForecast(location);

    HomeData homeData = _createHomeData(cityName, extendedForecast);

    if (homeData.forecastWindows == null || homeData.forecastWindows.length == 0) {
      home.homeState = HomeState.errorRetrievingConditions;
      _controller.sink.add(home);
      return;
    }

    home.homeState = HomeState.currentConditionsAvailable;
    home.homeData = homeData;
    _controller.sink.add(home);
  }

  Future<String> _getCityName(Location location) async {
    final WeatherLocale weatherLocale = await _weatherService.getWeatherLocale(location);

    return weatherLocale.locationInformation.cityName;
  }

  HomeData _createHomeData(String cityName, ExtendedForecast forecast) {
    //get the current conditions for today
    final CurrentConditions currentConditions = forecast.currentConditions;

    //find all forecast details for today
    //final today = DateTime.now();
    final today = DateTime.fromMillisecondsSinceEpoch(currentConditions.timeStampUTC * 1000, isUtc: false);

    HomeData homeData = HomeData();
    homeData.forecastWindows = new List<ForecastWindow>();

    //seed hi and low temps
    homeData.hiForDay = -999;
    homeData.lowForDay = 999;
    homeData.city = cityName;

    homeData.currentTemperature = currentConditions.currentTemperature;
    homeData.currentWindSpeed = currentConditions.windSpeed;

    //the weather details are an arrey, should only be one
    //TODO protect against index out of bounds
    homeData.currentConditionsDescription = currentConditions.weather[0].description;
    homeData.currentConditionsImageCode = currentConditions.weather[0].imageCode;

    homeData.feelsLikeTemperature = currentConditions.feelsLikeTemperature;

    forecast.hourlyForecast.forEach((hourlyWindow) {
      //get the forecasted time in local time (given in UTC)
      DateTime ft = DateTime.fromMillisecondsSinceEpoch(hourlyWindow.timeStampUTC * 1000, isUtc: false);

      if (today.day == ft.day) {
        DateFormat dateFormat = DateFormat.jm();

        //TODO protect agains index out of bounds
        final ForecastWindow fw = ForecastWindow(dateFormat.format(ft), hourlyWindow.temperatureFarenheit,
            hourlyWindow.weather[0].imageCode, hourlyWindow.probabilityOfPercipitation);

        homeData.forecastWindows.add(fw);

        if (homeData.hiForDay < hourlyWindow.temperatureFarenheit) {
          homeData.hiForDay = hourlyWindow.temperatureFarenheit;
        }

        if (homeData.lowForDay > hourlyWindow.temperatureFarenheit) {
          homeData.lowForDay = hourlyWindow.temperatureFarenheit;
        }
      }
    });

    return homeData;
  }

  Future<Location> _getCurrentLocation() async {
    return await _appPreferences.getLocation();
  }

  @override
  void dispose() {
    _controller.close();
    _locationEventStream.cancel();
  }
}

class Home {
  HomeState homeState;
  HomeData homeData;
}

enum HomeState { init, gettingLatestWeather, noLocationAvailable, currentConditionsAvailable, errorRetrievingConditions }

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
  final String windowStartHour;
  final double temp;
  final String imageCode;
  final double chanceOfPrecipitation;

  String get imageUrl {
    return getImageUrlFromIconCode(imageCode);
  }

  ForecastWindow(this.windowStartHour, this.temp, this.imageCode, this.chanceOfPrecipitation);
}
