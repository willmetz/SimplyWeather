// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExtendedForecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtendedForecast _$ExtendedForecastFromJson(Map<String, dynamic> json) {
  return ExtendedForecast(
    (json['daily'] as List)
        ?.map((e) => e == null
            ? null
            : DailyForecast.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['hourly'] as List)
        ?.map((e) => e == null
            ? null
            : HourlyForecast.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['current'] == null
        ? null
        : CurrentConditions.fromJson(json['current'] as Map<String, dynamic>),
    json['timezone'] as String,
  )..retrievedAtTimeStamp = json['retrievedAtTimeStamp'] as int;
}

Map<String, dynamic> _$ExtendedForecastToJson(ExtendedForecast instance) =>
    <String, dynamic>{
      'retrievedAtTimeStamp': instance.retrievedAtTimeStamp,
      'daily': instance.dailyForecasts?.map((e) => e?.toJson())?.toList(),
      'hourly': instance.hourlyForecast?.map((e) => e?.toJson())?.toList(),
      'current': instance.currentConditions?.toJson(),
      'timezone': instance.forecastTimezone,
    };

CurrentConditions _$CurrentConditionsFromJson(Map<String, dynamic> json) {
  return CurrentConditions(
    json['dt'] as int ?? 0,
    json['sunrise'] as int ?? 0,
    json['sunset'] as int ?? 0,
    (json['temp'] as num)?.toDouble() ?? 0,
    (json['feels_like'] as num)?.toDouble() ?? 0,
    (json['humidity'] as num)?.toDouble() ?? 0,
    (json['wind_speed'] as num)?.toDouble() ?? 0,
    (json['wind_deg'] as num)?.toDouble() ?? 0,
    (json['weather'] as List)
        ?.map((e) =>
            e == null ? null : Weather.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CurrentConditionsToJson(CurrentConditions instance) =>
    <String, dynamic>{
      'dt': instance.timeStampUTC,
      'sunrise': instance.sunriseUTC,
      'sunset': instance.sunsetUTC,
      'temp': instance.currentTemperature,
      'feels_like': instance.feelsLikeTemperature,
      'humidity': instance.humidity,
      'wind_speed': instance.windSpeed,
      'wind_deg': instance.windDirection,
      'weather': instance.weather?.map((e) => e?.toJson())?.toList(),
    };

HourlyForecast _$HourlyForecastFromJson(Map<String, dynamic> json) {
  return HourlyForecast(
    json['dt'] as int,
    (json['temp'] as num)?.toDouble() ?? 0,
    (json['feels_like'] as num)?.toDouble() ?? 0,
    (json['humidity'] as num)?.toDouble() ?? 0,
    (json['wind_speed'] as num)?.toDouble() ?? 0,
    (json['wind_deg'] as num)?.toDouble() ?? 0,
    (json['weather'] as List)
        ?.map((e) =>
            e == null ? null : Weather.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['pop'] as num)?.toDouble() ?? 0,
  );
}

Map<String, dynamic> _$HourlyForecastToJson(HourlyForecast instance) =>
    <String, dynamic>{
      'dt': instance.timeStampUTC,
      'temp': instance.temperatureFarenheit,
      'feels_like': instance.feelsLike,
      'humidity': instance.humidity,
      'wind_speed': instance.windSpeed,
      'wind_deg': instance.windDirection,
      'weather': instance.weather?.map((e) => e?.toJson())?.toList(),
      'pop': instance.probabilityOfPercipitation,
    };

DailyForecast _$DailyForecastFromJson(Map<String, dynamic> json) {
  return DailyForecast(
    json['temp'] == null
        ? null
        : DailyTemperatureRange.fromJson(json['temp'] as Map<String, dynamic>),
    json['dt'] as int,
    (json['wind_speed'] as num)?.toDouble(),
    json['wind_deg'] as int,
    (json['weather'] as List)
        ?.map((e) =>
            e == null ? null : Weather.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DailyForecastToJson(DailyForecast instance) =>
    <String, dynamic>{
      'temp': instance.dailyTemperatureRange?.toJson(),
      'dt': instance.utcTimeStamp,
      'wind_speed': instance.windSpeed,
      'wind_deg': instance.windDirectionDegrees,
      'weather': instance.weather?.map((e) => e?.toJson())?.toList(),
    };

DailyTemperatureRange _$DailyTemperatureRangeFromJson(
    Map<String, dynamic> json) {
  return DailyTemperatureRange(
    (json['day'] as num)?.toDouble(),
    (json['min'] as num)?.toDouble(),
    (json['max'] as num)?.toDouble(),
    (json['night'] as num)?.toDouble(),
    (json['eve'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$DailyTemperatureRangeToJson(
        DailyTemperatureRange instance) =>
    <String, dynamic>{
      'day': instance.dayTimeTemp,
      'min': instance.lowTemp,
      'max': instance.hiTemp,
      'night': instance.nightTemp,
      'eve': instance.eveningTemp,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
    json['main'] as String ?? '',
    json['description'] as String ?? '',
    json['icon'] as String ?? '',
  );
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'main': instance.condition,
      'description': instance.description,
      'icon': instance.imageCode,
    };
