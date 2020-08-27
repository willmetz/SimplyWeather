import 'package:json_annotation/json_annotation.dart';

import 'WeatherLocale.dart';

/// This allows the `ExtendedForecast` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'ExtendedForecast.g.dart';

@JsonSerializable(explicitToJson: true)
class ExtendedForecast {
  ExtendedForecast(this.dailyForecasts, this.forecastTimezone, this.retrievedAtTimeStamp);

  //This does not come from the service butis needed to record timestamp
  int retrievedAtTimeStamp;

  //there is a lot more data to deserialize if needed

  @JsonKey(name: 'daily')
  List<DailyForecast> dailyForecasts;

  @JsonKey(name: 'hourly')
  List<HourlyForecast> hourlyForecast;

  @JsonKey(name: 'current')
  CurrentConditions currentConditions;

  @JsonKey(name: 'timezone')
  String forecastTimezone;

  /// A necessary factory constructor for creating a new ExtendedForecast instance
  /// from a map. Pass the map to the generated `_$ExtendedForecastFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ExtendedForecast.fromJson(Map<String, dynamic> json) => _$ExtendedForecastFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$ExtendedForecastToJson`.
  Map<String, dynamic> toJson() => _$ExtendedForecastToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CurrentConditions {
  CurrentConditions(this.currentTemperature, this.feelsLikeTemperature, this.humidity, this.sunriseUTC, this.sunsetUTC,
      this.timeStampUTC, this.weather, this.windDirection, this.windSpeed);

  @JsonKey(name: 'dt', defaultValue: 0)
  int timeStampUTC;

  @JsonKey(name: 'sunrise', defaultValue: 0)
  int sunriseUTC;

  @JsonKey(name: 'sunset', defaultValue: 0)
  int sunsetUTC;

  @JsonKey(name: 'temp', defaultValue: 0)
  double currentTemperature;

  @JsonKey(name: 'feels_like', defaultValue: 0)
  double feelsLikeTemperature;

  @JsonKey(name: 'humidity', defaultValue: 0)
  double humidity;

  @JsonKey(name: 'wind_speed', defaultValue: 0)
  double windSpeed;

  @JsonKey(name: 'wind_deg', defaultValue: 0)
  double windDirection;

  @JsonKey(name: 'weather')
  List<Weather> weather;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$CurrentConditionsFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory CurrentConditions.fromJson(Map<String, dynamic> json) => _$CurrentConditionsFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CurrentConditionsToJson`.
  Map<String, dynamic> toJson() => _$CurrentConditionsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class HourlyForecast {
  HourlyForecast(this.feelsLike, this.weather, this.humidity, this.probabilityOfPercipitation, this.temperatureFarenheit,
      this.timeStampUTC, this.windDirection, this.windSpeed);

  @JsonKey(name: 'dt')
  int timeStampUTC;

  @JsonKey(name: 'temp', defaultValue: 0)
  double temperatureFarenheit;

  @JsonKey(name: 'feels_like', defaultValue: 0)
  double feelsLike;

  @JsonKey(name: 'humidity', defaultValue: 0)
  double humidity;

  @JsonKey(name: 'wind_speed', defaultValue: 0)
  double windSpeed;

  @JsonKey(name: 'wind_deg', defaultValue: 0)
  double windDirection;

  @JsonKey(name: 'weather')
  List<Weather> weather;

  @JsonKey(name: 'pop', defaultValue: 0)
  double probabilityOfPercipitation;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$HourlyForecastFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory HourlyForecast.fromJson(Map<String, dynamic> json) => _$HourlyForecastFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$HourlyForecastToJson`.
  Map<String, dynamic> toJson() => _$HourlyForecastToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DailyForecast {
  DailyForecast(this.weather, this.windSpeed, this.dailyTemperatureRange, this.utcTimeStamp, this.windDirectionDegrees);

  @JsonKey(name: 'temp')
  DailyTemperatureRange dailyTemperatureRange;

  @JsonKey(name: 'dt')
  int utcTimeStamp;

  @JsonKey(name: 'wind_speed')
  double windSpeed;

  @JsonKey(name: 'wind_deg')
  int windDirectionDegrees;

  @JsonKey(name: 'weather')
  List<Weather> weather;

  /// A necessary factory constructor for creating a new DailyForecast instance
  /// from a map. Pass the map to the generated `_$DailyForecastFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory DailyForecast.fromJson(Map<String, dynamic> json) => _$DailyForecastFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$DailyForecastToJson`.
  Map<String, dynamic> toJson() => _$DailyForecastToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DailyTemperatureRange {
  DailyTemperatureRange(this.dayTimeTemp, this.hiTemp, this.lowTemp, this.eveningTemp, this.nightTemp);

  @JsonKey(name: 'day')
  double dayTimeTemp;

  @JsonKey(name: 'min')
  double lowTemp;

  @JsonKey(name: 'max')
  double hiTemp;

  @JsonKey(name: 'night')
  double nightTemp;

  @JsonKey(name: 'eve')
  double eveningTemp;

  /// A necessary factory constructor for creating a new DailyTemperatureRange instance
  /// from a map. Pass the map to the generated `_$DailyTemperatureRangeFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory DailyTemperatureRange.fromJson(Map<String, dynamic> json) => _$DailyTemperatureRangeFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$DailyTemperatureRangeToJson`.
  Map<String, dynamic> toJson() => _$DailyTemperatureRangeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Weather {
  Weather(this.condition, this.description, this.imageCode);

  @JsonKey(name: 'main', defaultValue: "")
  String condition;

  @JsonKey(name: 'description', defaultValue: "")
  String description;

  @JsonKey(name: 'icon', defaultValue: "")
  String imageCode;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$WeatherFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$WeatherToJson`.
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
