import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metronome/data/theme.dart';
import 'package:metronome/data/cities.dart';

class WorldMap extends StatefulWidget {
  const WorldMap({Key? key}) : super(key: key);

  @override
  _WorldMapState createState() => _WorldMapState();
}

class _WorldMapState extends State<WorldMap> {
  ui.Image? image;

  // A function that loads an image from the
  // app assets as a ui.Image object
  Future loadImage(String path) async {
    // Load image from app assets
    final data = await rootBundle.load(path);
    // Read image into bytes
    final bytes = data.buffer.asUint8List();
    // Decode the bytes into a ui.Image
    final image = await decodeImageFromList(bytes);

    setState(() {
      // Set the image state variable
      this.image = image;
    });
  }

  @override
  void initState() {
    // Load the image asset
    loadImage("assets/worldmap.png");
    // Call the initState method of the super class
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return image == null
        ? CircularProgressIndicator()
        : Container(
            height: 230,
            width: 380,
            child: FittedBox(
              child: SizedBox(
                height: image!.height.toDouble(),
                width: image!.width.toDouble(),
                child: CustomPaint(
                  painter: MapPainter(image!),
                ),
              ),
            ),
          );
  }
}

class MapPainter extends CustomPainter {
  final ui.Image image;
  const MapPainter(this.image);

  void paint(Canvas canvas, Size size) {
    // Calculate map center coordinates
    var mapcenterX = image.width.toDouble() / 2;
    var mapcenterY = image.height.toDouble() / 2;

    // Calculate map center
    var center = Offset(mapcenterX, mapcenterY);
    // Calculate a scale based on the image size
    var scale = min(image.width.toDouble(), image.width.toDouble()) / 100;

    // Define the brush for the city point border
    var outerbrush = Paint()
      ..color = AppColors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = scale * 5;

    // Define the brush for the city point
    var innerbrush = Paint()
      ..color = AppColors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = scale * 2.5;

    // <Test> Define a few city points (Will be replaced with some external data)
    var chennai = CityPoint(center, "chennai").point;
    var newyork = CityPoint(center, "newyork").point;
    var losangeles = CityPoint(center, "losangeles").point;

    // Draw the world map
    canvas.drawImage(image, Offset.zero, Paint());

    // Draw the city point borders
    canvas.drawPoints(
      ui.PointMode.points,
      [chennai, newyork, losangeles],
      outerbrush,
    );

    // Draw the city points
    canvas.drawPoints(
      ui.PointMode.points,
      [chennai, newyork, losangeles],
      innerbrush,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
