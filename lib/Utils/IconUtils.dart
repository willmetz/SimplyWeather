final _imageURLPrefix = "https://openweathermap.org/img/w/";

String getImageUrlFromIconCode(String iconCode) {
  if (iconCode == null || iconCode == "") {
    return "";
  }

  return _imageURLPrefix + iconCode + ".png";
}
