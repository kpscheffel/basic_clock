import 'dart:math';

import 'package:flutter/material.dart';

class ClockFace extends CustomPainter {
  final int second;
  final int minute;
  final int hour;
  final double transSecond;

  ClockFace(this.hour, this.minute, this.second, this.transSecond);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    final double width = size.width;
    final double diameter = (width - 50) / 2;
    final double xMiddle = width / 2;
    final double yMiddle = size.height / 2;
    final double displayLength = diameter * 7 / 9;

    //Draw Clock Face
    paint.strokeWidth = 3;
    paint.color = Colors.white;
    for (int i = 0; i < 12; i++) {
      final double radianRotation = i * (2 * pi / 12);
      canvas.drawLine(
        Offset(
          xMiddle - cos(radianRotation) * displayLength,
          yMiddle - sin(radianRotation) * displayLength,
        ),
        Offset(
          xMiddle - cos(radianRotation) * diameter,
          yMiddle - sin(radianRotation) * diameter,
        ),
        paint,
      );
    }

    // Draw inner white circle
    canvas.drawCircle(Offset(xMiddle, yMiddle), diameter / 15, paint);

    // Now draw the hands
    // Hour Hand
    paint.strokeWidth = 10;
    final double hourRotation = (hour * 60 + minute) / 720 * (2 * pi);
    canvas.drawLine(
      Offset(xMiddle, yMiddle),
      Offset(
        xMiddle + sin(hourRotation) * diameter * 2 / 3,
        yMiddle - cos(hourRotation) * diameter * 2 / 3,
      ),
      paint,
    );

    // Minute Hand
    paint.color = const Color.fromRGBO(0, 0, 255, 1);
    paint.strokeWidth = 4;
    double minuteRotation = 0;
    if (second == 59) {
      //Create the minute hand animation
      minuteRotation = (minute + (transSecond * 5)) * (2 * pi / 60);
    } else {
      minuteRotation = minute * (2 * pi / 60);
    }
    canvas.drawLine(
      Offset(xMiddle, yMiddle),
      Offset(
        xMiddle + sin(minuteRotation) * (displayLength + 20),
        yMiddle - cos(minuteRotation) * (displayLength + 20),
      ),
      paint,
    );

    // Second Hand
    paint.color = Colors.red;
    paint.strokeWidth = 3;
    double secondRotation = 0.0;
    secondRotation = (second + (transSecond * 5)) * (2 * pi / 60);

    canvas.drawLine(
      Offset(
        xMiddle - sin(secondRotation) * diameter * 1 / 5,
        yMiddle + cos(secondRotation) * diameter * 1 / 5,
      ),
      Offset(
        xMiddle + sin(secondRotation) * (diameter - 5),
        yMiddle - cos(secondRotation) * (diameter - 5),
      ),
      paint,
    );

    // Draw inner red circle
    canvas.drawCircle(Offset(xMiddle, yMiddle), diameter / 20, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
