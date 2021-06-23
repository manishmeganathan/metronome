import 'package:flutter/material.dart';

class Point {
  double x;
  double y;

  Point(this.x, this.y);

  static Point southindia = Point(1.42, 1.19);
  static Point newyork = Point(0.54, 0.84);
  static Point california = Point(0.275, 1.02);
}

Map<String, Point> cities = {
  "chennai": Point.southindia,
  "bangalore": Point.southindia,
  "newyork": Point.newyork,
  "newjersey": Point.newyork,
  "losangeles": Point.california,
  "sanfrancisco": Point.california,
};

class CityPoint {
  late Offset point;

  CityPoint(Offset base, String city) {
    Point citypoint = cities[city]!;
    this.point = base.scale(citypoint.x, citypoint.y);
  }
}
