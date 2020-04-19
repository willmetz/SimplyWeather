// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HourlyForecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyForecast _$HourlyForecastFromJson(Map<String, dynamic> json) {
  return HourlyForecast(
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

Map<String, dynamic> _$HourlyForecastToJson(HourlyForecast instance) =>
    <String, dynamic>{
      'list': instance.forecastIntervals,
      'city': instance.locationInformation,
    };

ForecastInterval _$ForecastIntervalFromJson(Map<String, dynamic> json) {
  return ForecastInterval(
    json['dt_txt'] as String ?? '',
    (json['weather'] as List)
        ?.map((e) =>
            e == null ? null : Weather.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['main'] == null
        ? null
        : WeatherReadings.fromJson(json['main'] as Map<String, dynamic>),
  )
    ..timeStampUTC = json['dt'] as int
    ..windDetails = json['wind'] == null
        ? null
        : WindDetails.fromJson(json['wind'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ForecastIntervalToJson(ForecastInterval instance) =>
    <String, dynamic>{
      'dt': instance.timeStampUTC,
      'main': instance.weatherReadings,
      'weather': instance.weather,
      'wind': instance.windDetails,
      'dt_txt': instance.periodStartTimestamp,
    };

WeatherReadings _$WeatherReadingsFromJson(Map<String, dynamic> json) {
  return WeatherReadings(
    (json['temp'] as num)?.toDouble() ?? 0,
    (json['temp_max'] as num)?.toDouble() ?? 0,
    (json['temp_min'] as num)?.toDouble() ?? 0,
    (json['feels_like'] as num)?.toDouble() ?? 0,
    (json['humidity'] as num)?.toDouble() ?? 0,
  );
}

Map<String, dynamic> _$WeatherReadingsToJson(WeatherReadings instance) =>
    <String, dynamic>{
      'temp': instance.temperatureFarenheit,
      'temp_min': instance.minTempFarenheit,
      'temp_max': instance.maxTempFarenheit,
      'humidity': instance.humidity,
      'feels_like': instance.feelsLike,
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

WindDetails _$WindDetailsFromJson(Map<String, dynamic> json) {
  return WindDetails(
    (json['deg'] as num)?.toDouble(),
    (json['speed'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$WindDetailsToJson(WindDetails instance) =>
    <String, dynamic>{
      'speed': instance.windSpeed,
      'deg': instance.windDirection,
    };
