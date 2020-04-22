import 'dart:async';

import 'package:intl/intl.dart';
import 'package:ost_weather/Bloc/Bloc.dart';
import 'package:ost_weather/DataLayer/Location.dart';
import 'package:ost_weather/DataLayer/WeatherClient.dart';
import 'package:ost_weather/Utils/IconUtils.dart';

class ExtendedForecastBloc extends Bloc {
  final _client = WeatherClient();
  final _controller = StreamController<ExtendedForecastData>();

  Stream<ExtendedForecastData> get stream => _controller.stream;

  void GetExtendedForecast(Location location) async {
    ExtendedForecastData extendedForecastData = ExtendedForecastData();
    extendedForecastData.extendedForecast = new List();

    var rawData = await _client.getExtendedForecastFromFile();

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
    if (windDirectionDegrees >= 0 && windDirectionDegrees < 22.5 || windDirectionDegrees > 337.5 && windDirectionDegrees <= 360) {
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
  }
}

class ExtendedForecastData {
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