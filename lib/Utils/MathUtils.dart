import 'dart:math';

num degreesToRads(num deg) {
  return (deg * pi) / 180.0;
}

double asinh(double value) {
  //credit from: https://pub.dev/documentation/dart_numerics/latest/dart_numerics/asinh.html
  if (value.abs() >= 268435456.0) // 2^28, taken from freeBSD
    return value.sign * (log(value.abs()) + log(2.0));

  return value.sign * log(value.abs() + sqrt((value * value) + 1));
}
