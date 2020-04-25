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
    json['timezone'] as String,
    json['retrievedAtTimeStamp'] as int,
  );
}

Map<String, dynamic> _$ExtendedForecastToJson(ExtendedForecast instance) =>
    <String, dynamic>{
      'retrievedAtTimeStamp': instance.retrievedAtTimeStamp,
      'daily': instance.dailyForecasts,
      'timezone': instance.forecastTimezone,
    };

DailyForecast _$DailyForecastFromJson(Map<String, dynamic> json) {
  return DailyForecast(
    (json['weather'] as List)
        ?.map((e) =>
            e == null ? null : Weather.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['wind_speed'] as num)?.toDouble(),
    json['temp'] == null
        ? null
        : DailyTemperatureRange.fromJson(json['temp'] as Map<String, dynamic>),
    json['dt'] as int,
    json['wind_deg'] as int,
  );
}

Map<String, dynamic> _$DailyForecastToJson(DailyForecast instance) =>
    <String, dynamic>{
      'temp': instance.dailyTemperatureRange,
      'dt': instance.utcTimeStamp,
      'wind_speed': instance.windSpeed,
      'wind_deg': instance.windDirectionDegrees,
      'weather': instance.weather,
    };

DailyTemperatureRange _$DailyTemperatureRangeFromJson(
    Map<String, dynamic> json) {
  return DailyTemperatureRange(
    (json['day'] as num)?.toDouble(),
    (json['max'] as num)?.toDouble(),
    (json['min'] as num)?.toDouble(),
    (json['eve'] as num)?.toDouble(),
    (json['night'] as num)?.toDouble(),
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
