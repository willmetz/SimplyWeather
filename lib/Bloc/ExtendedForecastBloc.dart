import 'dart:async';

import 'package:intl/intl.dart';
import 'package:ost_weather/Bloc/Bloc.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/Service/LocationService.dart';
import 'package:ost_weather/Service/WeatherService.dart';
import 'package:ost_weather/Utils/AppPreference.dart';
import 'package:ost_weather/Utils/IconUtils.dart';

class ExtendedForecastBloc extends Bloc {
  final WeatherService _weatherService;
  final AppPreferences _appPreferences;
  final LocationService _locationService;
  StreamSubscription<Location> _locationEventStream;

  final _controller = StreamController<ExtendedForecastData>();

  ExtendedForecastBloc(this._weatherService, this._appPreferences, this._locationService) {
    _locationService.locationChangeEventStream.listen((location) {
      getExtendedForecast(providedLocation: location);
    });
  }

  Stream<ExtendedForecastData> get stream => _controller.stream;

  ExtendedForecastData getInitialData() {
    ExtendedForecastData extendedForecastData = ExtendedForecastData();
    extendedForecastData.extendedForecastState = ExtendedForecastState.init;

    return extendedForecastData;
  }

  void getExtendedForecast({Location providedLocation}) async {
    ExtendedForecastData extendedForecastData = ExtendedForecastData();
    extendedForecastData.extendedForecast = new List();

    Location location = providedLocation;

    if (location == null) {
      await _appPreferences.getLocation();
    }

    if (location != null) {
      extendedForecastData.extendedForecastState = ExtendedForecastState.loading;
      _controller.sink.add(extendedForecastData);

      var rawData = await _weatherService.getExtendedForecast(location);

      for (var dayData in rawData.dailyForecasts) {
        DaysForecast daysForecast = DaysForecast();

        daysForecast.day = getDayFromUTC(dayData.utcTimeStamp);
        daysForecast.highTemp = dayData.dailyTemperatureRange.hiTemp.toInt();
        daysForecast.lowTemp = dayData.dailyTemperatureRange.lowTemp.toInt();
        daysForecast.windSpeed = dayData.windSpeed.toInt();
        daysForecast.windDirection = getWindDirection(dayData.windDirectionDegrees);
        daysForecast.imageUrl = getImageUrlFromIconCode(dayData.weather[0].imageCode);
        daysForecast.weatherDescription = dayData.weather[0].description;

        extendedForecastData.extendedForecast.add(daysForecast);
      }

      if (extendedForecastData.extendedForecast.length > 0) {
        //we have data, mark the forecast as ready
        extendedForecastData.extendedForecastState = ExtendedForecastState.forecastReady;
      } else {
        extendedForecastData.extendedForecastState = ExtendedForecastState.forecastError;
      }
    } else {
      extendedForecastData.extendedForecastState = ExtendedForecastState.locationRequired;
    }

    _controller.sink.add(extendedForecastData);
  }

  String getDayFromUTC(int utcTime) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(utcTime * 1000, isUtc: false);

    var weekDayFormatter = DateFormat.EEEE();
    var monthFormatter = DateFormat.MMMM();

    String dayOfWeek = weekDayFormatter.format(dateTime);
    String monthOfYear = monthFormatter.format(dateTime);

    return dayOfWeek + ", " + monthOfYear + " " + dateTime.day.toString();
  }

  String getWindDirection(int windDirectionDegrees) {
    if (windDirectionDegrees >= 0 && windDirectionDegrees < 22.5 ||
        windDirectionDegrees > 337.5 && windDirectionDegrees <= 360) {
      return "E";
    } else if (windDirectionDegrees >= 22.5 && windDirectionDegrees < 67.5) {
      return "NE";
    } else if (windDirectionDegrees >= 67.5 && windDirectionDegrees < 112.5) {
      return "N";
    } else if (windDirectionDegrees >= 112.5 && windDirectionDegrees < 157.5) {
      return "NW";
    } else if (windDirectionDegrees >= 157.5 && windDirectionDegrees < 202.5) {
      return "W";
    } else if (windDirectionDegrees >= 202.5 && windDirectionDegrees < 247.5) {
      return "SW";
    } else if (windDirectionDegrees >= 247.5 && windDirectionDegrees < 292.5) {
      return "S";
    } else {
      return "SE";
    }
  }

  @override
  void dispose() {
    _controller.close();
    _locationEventStream.cancel();
  }
}

enum ExtendedForecastState { init, loading, locationRequired, forecastReady, forecastError }

class ExtendedForecastData {
  ExtendedForecastState extendedForecastState;
  List<DaysForecast> extendedForecast;
}

class DaysForecast {
  String day;
  int highTemp;
  int lowTemp;
  int windSpeed;
  String windDirection;
  String imageUrl;
  String weatherDescription;
}
