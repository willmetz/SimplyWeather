// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DailyForecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyForecast _$DailyForecastFromJson(Map<String, dynamic> json) {
  return DailyForecast(
    json['city'] == null
        ? null
        : LocationInformation.fromJson(json['city'] as Map<String, dynamic>),
    (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : ForecastInterval.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DailyForecastToJson(DailyForecast instance) =>
    <String, dynamic>{
      'list': instance.forecastIntervals,
      'city': instance.locationInformation,
    };

ForecastInterval _$ForecastIntervalFromJson(Map<String, dynamic> json) {
  return ForecastInterval(
    json['dt_txt'] as String ?? '',
    json['weather'] == null
        ? null
        : Weather.fromJson(json['weather'] as Map<String, dynamic>),
    json['main'] == null
        ? null
        : WeatherReadings.fromJson(json['main'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ForecastIntervalToJson(ForecastInterval instance) =>
    <String, dynamic>{
      'main': instance.weatherReadings,
      'weather': instance.weather,
      'dt_txt': instance.periodStartTimestamp,
    };

WeatherReadings _$WeatherReadingsFromJson(Map<String, dynamic> json) {
  return WeatherReadings(
    (json['temp'] as num)?.toDouble() ?? 0,
    (json['temp_max'] as num)?.toDouble() ?? 0,
    (json['temp_min'] as num)?.toDouble() ?? 0,
    (json['feelsLike'] as num)?.toDouble() ?? 0,
    (json['humidity'] as num)?.toDouble() ?? 0,
  );
}

Map<String, dynamic> _$WeatherReadingsToJson(WeatherReadings instance) =>
    <String, dynamic>{
      'temp': instance.temperatureFarenheit,
      'temp_min': instance.minTempFarenheit,
      'temp_max': instance.maxTempFarenheit,
      'humidity': instance.humidity,
      'feelsLike': instance.feelsLike,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
    json['main'] as String ?? '',
    json['description'] as String ?? '',
  );
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'main': instance.condition,
      'description': instance.description,
    };

LocationInformation _$LocationInformationFromJson(Map<String, dynamic> json) {
  return LocationInformation(
    json['name'] as String ?? '',
    json['country'] as String ?? '',
  );
}

Map<String, dynamic> _$LocationInformationToJson(
        LocationInformation instance) =>
    <String, dynamic>{
      'name': instance.cityName,
      'country': instance.country,
    };
