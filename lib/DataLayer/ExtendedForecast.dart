import 'package:json_annotation/json_annotation.dart';

import 'HourlyForecast.dart';

/// This allows the `ExtendedForecast` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'ExtendedForecast.g.dart';

@JsonSerializable()
class ExtendedForecast {
  ExtendedForecast(this.dailyForecasts, this.forecastTimezone);

  //there is a lot more data to deserialize if needed

  @JsonKey(name: 'daily')
  List<DailyForecast> dailyForecasts;

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

@JsonSerializable()
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

@JsonSerializable()
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
