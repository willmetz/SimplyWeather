class Location {
  Location(this.zipCode);
  Location.fromGeoInfo(this.latitude, this.longitude);
  Location.allForms(this.zipCode, this.longitude, this.latitude);

  int zipCode;
  int latitude;
  int longitude;
}
