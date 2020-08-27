import 'package:json_annotation/json_annotation.dart';

/// This allows the `WeatherLocale` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'WeatherLocale.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
class WeatherLocale {
  WeatherLocale(this.locationInformation);

  //this is not returned from the service, tracked locally for cache reasons
  int retrievedAtTimeStamp;

  @JsonKey(name: 'city', defaultValue: null)
  LocationInformation locationInformation;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$WeatherLocaleFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory WeatherLocale.fromJson(Map<String, dynamic> json) => _$WeatherLocaleFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$WeatherLocaleToJson`.
  Map<String, dynamic> toJson() => _$WeatherLocaleToJson(this);
}

@JsonSerializable(explicitToJson: true)
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
