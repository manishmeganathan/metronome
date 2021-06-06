import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  const ClockView({ Key? key }) : super(key: key);

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {

  @override 
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Transform.rotate(
        angle: -pi/2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
  
    var centerX = size.width / 2 ;
    var centerY = size.height / 2;

    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()
    ..color = Color(0xFF444974);

    var outlineBrush = Paint()
    ..color = Color(0xFFEAECFF)
    .. style = PaintingStyle.stroke
    ..strokeWidth = 16;

    var centerFillBrush = Paint()..color = Color(0xFFEAECFF);

    var secondHandBrush = Paint()
    ..color = Colors.orange.shade300
    .. style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 8;

    var minuteHandBrush = Paint()
    ..shader = RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
      .createShader(Rect.fromCircle(center: center, radius: radius))
    .. style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 12;

    var hourHandBrush = Paint()
    ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
      .createShader(Rect.fromCircle(center: center, radius: radius))
    .. style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 16;

    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    var datetime = DateTime.now();

    var minhandX = centerX + 70 * cos(datetime.minute * 6 * pi / 180);
    var minhandY = centerX + 70 * sin(datetime.minute * 6 * pi / 180);

    canvas.drawLine(center, Offset(minhandX, minhandY), minuteHandBrush);

    var hourhandX = centerX + 50 * cos((datetime.hour * 30 + datetime.minute * 0.5) * pi / 180);
    var hourhandY = centerX + 50 * sin((datetime.hour * 30 + datetime.minute * 0.5) * pi / 180);

    canvas.drawLine(center, Offset(hourhandX, hourhandY), hourHandBrush);

    var sechandX = centerX + 80 * cos(datetime.second * 6 * pi / 180);
    var sechandY = centerX + 80 * sin(datetime.second * 6 * pi / 180);

    canvas.drawLine(center, Offset(sechandX, sechandY), secondHandBrush);
    
    canvas.drawCircle(center, 16, centerFillBrush);

    var outerRadius = radius;
    var innerRadius = radius * 0.9;

    for (var i = 0; i < 360; i += 12) {
      var x1 = centerX + outerRadius * cos(i * pi / 180);
      var y1 = centerY + outerRadius * sin(i * pi / 180);

      var x2 = centerX + innerRadius * cos(i * pi / 180);
      var y2 = centerY + innerRadius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}