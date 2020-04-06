import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'DailyForecast.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class DailyForecast {
  DailyForecast(this.locationInformation, this.forecastIntervals);

  @JsonKey(name: 'list', defaultValue: null)
  List<ForecastInterval> forecastIntervals;

  @JsonKey(name: 'city', defaultValue: null)
  LocationInformation locationInformation;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$DailyForecastFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory DailyForecast.fromJson(Map<String, dynamic> json) => _$DailyForecastFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$DailyForecastToJson`.
  Map<String, dynamic> toJson() => _$DailyForecastToJson(this);
}

@JsonSerializable()
class ForecastInterval {
  ForecastInterval(this.periodStartTimestamp, this.weather, this.weatherReadings);

  @JsonKey(name: 'main')
  WeatherReadings weatherReadings;

  @JsonKey(name: 'weather')
  Weather weather;

  @JsonKey(name: 'dt_txt', defaultValue: "")
  String periodStartTimestamp;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$ForecastIntervalFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ForecastInterval.fromJson(Map<String, dynamic> json) => _$ForecastIntervalFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$ForecastIntervalToJson`.
  Map<String, dynamic> toJson() => _$ForecastIntervalToJson(this);
}

@JsonSerializable()
class WeatherReadings {
  WeatherReadings(this.temperatureFarenheit, this.maxTempFarenheit, this.minTempFarenheit, this.feelsLike, this.humidity);

  @JsonKey(name: 'temp', defaultValue: 0)
  double temperatureFarenheit;

  @JsonKey(name: 'temp_min', defaultValue: 0)
  double minTempFarenheit;

  @JsonKey(name: 'temp_max', defaultValue: 0)
  double maxTempFarenheit;

  @JsonKey(name: 'humidity', defaultValue: 0)
  double humidity;

  @JsonKey(name: 'feelsLike', defaultValue: 0)
  double feelsLike;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$WeatherReadingsFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory WeatherReadings.fromJson(Map<String, dynamic> json) => _$WeatherReadingsFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$WeatherReadingsToJson`.
  Map<String, dynamic> toJson() => _$WeatherReadingsToJson(this);
}

@JsonSerializable()
class Weather {
  Weather(this.condition, this.description);

  @JsonKey(name: 'main', defaultValue: "")
  String condition;

  @JsonKey(name: 'description', defaultValue: "")
  String description;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$WeatherFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$WeatherToJson`.
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class LocationInformation {
  LocationInformation(this.cityName, this.country);

  @JsonKey(name: 'name', defaultValue: "")
  String cityName;

  @JsonKey(name: 'country', defaultValue: "")
  String country;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$LocationInformationFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory LocationInformation.fromJson(Map<String, dynamic> json) => _$LocationInformationFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$LocationInformationToJson`.
  Map<String, dynamic> toJson() => _$LocationInformationToJson(this);
}
