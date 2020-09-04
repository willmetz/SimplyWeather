class Location {
  static const double UNKNOWN_LOCATION = 999;

  Location(this.zipCode);
  Location.fromGeoInfo(this.latitude, this.longitude);
  Location.allForms(this.zipCode, this.longitude, this.latitude);

  int zipCode;
  double latitude;
  double longitude;

  bool hasLocation() {
    return latitude != UNKNOWN_LOCATION && longitude != UNKNOWN_LOCATION;
  }
}
