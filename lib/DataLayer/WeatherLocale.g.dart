// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeatherLocale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherLocale _$WeatherLocaleFromJson(Map<String, dynamic> json) {
  return WeatherLocale(
    json['city'] == null
        ? null
        : LocationInformation.fromJson(json['city'] as Map<String, dynamic>),
  )..retrievedAtTimeStamp = json['retrievedAtTimeStamp'] as int;
}

Map<String, dynamic> _$WeatherLocaleToJson(WeatherLocale instance) =>
    <String, dynamic>{
      'retrievedAtTimeStamp': instance.retrievedAtTimeStamp,
      'city': instance.locationInformation?.toJson(),
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
