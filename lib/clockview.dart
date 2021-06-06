import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {

  final double? size;

  const ClockView({ Key? key, double? this.size }) : super(key: key);

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
      width: widget.size,
      height: widget.size,
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
    ..strokeWidth = size.width / 20;

    var centerFillBrush = Paint()..color = Color(0xFFEAECFF);

    var secondHandBrush = Paint()
    ..color = Colors.orange.shade300
    .. style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = size.width / 40;

    var minuteHandBrush = Paint()
    ..shader = RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
      .createShader(Rect.fromCircle(center: center, radius: radius))
    .. style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = size.width / 20;

    var hourHandBrush = Paint()
    ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
      .createShader(Rect.fromCircle(center: center, radius: radius))
    .. style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = size.width / 15;

    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius * 0.75, fillBrush);
    canvas.drawCircle(center, radius * 0.75, outlineBrush);

    var datetime = DateTime.now();

    var minhandX = centerX + radius * 0.55 * cos(datetime.minute * 6 * pi / 180);
    var minhandY = centerX + radius * 0.55 * sin(datetime.minute * 6 * pi / 180);

    canvas.drawLine(center, Offset(minhandX, minhandY), minuteHandBrush);

    var hourhandX = centerX + radius * 0.4 * cos((datetime.hour * 30 + datetime.minute * 0.5) * pi / 180);
    var hourhandY = centerX + radius * 0.4 * sin((datetime.hour * 30 + datetime.minute * 0.5) * pi / 180);

    canvas.drawLine(center, Offset(hourhandX, hourhandY), hourHandBrush);

    var sechandX = centerX + radius * 0.6 * cos(datetime.second * 6 * pi / 180);
    var sechandY = centerX + radius * 0.6 * sin(datetime.second * 6 * pi / 180);

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