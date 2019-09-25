import 'package:flutter/material.dart';
import 'dart:math';

class ClockFace extends CustomPainter {
  int second;
  int minute;
  int hour;

  ClockFace (int _hour, int _minute, int _second)
  {
    hour = _hour;
    minute = _minute;
    second = _second;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    double width = size.width;
    double diameter = (width - 50) / 2;
    double xMiddle = width / 2;
    double yMiddle = size.height / 2;
    double displayLength = diameter * 7 / 9;

    //Draw Clock Face
    paint.strokeWidth = 3;
    paint.color = Colors.white;
    for (var i = 0; i < 12; i++) {
      double radianRotation = i * (2 * pi / 12);
      canvas.drawLine(Offset(xMiddle - cos(radianRotation) * displayLength,
                            yMiddle - sin(radianRotation) * displayLength),
                      Offset(xMiddle - cos(radianRotation) * diameter, 
                            yMiddle - sin(radianRotation) * diameter),
                      paint);
      
    }

    // Draw inner white circle
    canvas.drawCircle(Offset(xMiddle,yMiddle), diameter / 15, paint);

    // Now draw the hands - keep it simple for now
    // Hour Hand
    paint.strokeWidth = 10;
    double hourRotation = (hour * 60 + minute) / 720  * (2 * pi);
    canvas.drawLine(Offset(xMiddle,yMiddle), 
                    Offset(xMiddle + sin(hourRotation)* diameter * 2 / 3,
                           yMiddle - cos(hourRotation) * diameter * 2 / 3),
                    paint);

    // Minute Hand
    paint.color = Color.fromRGBO(0, 0, 255, 1);
    paint.strokeWidth = 4;
    double minuteRotation = minute * (2 * pi / 60);
    canvas.drawLine(Offset(xMiddle,yMiddle), 
                    Offset(xMiddle + sin(minuteRotation)* diameter,
                           yMiddle - cos(minuteRotation) * diameter),
                    paint);

    // Second Hand
    paint.color = Colors.red;
    paint.strokeWidth = 3;
    double secondRotation = second * (2 * pi / 60);
    canvas.drawLine(Offset(xMiddle - sin(secondRotation) * diameter * 1 / 5,
                           yMiddle + cos(secondRotation) * diameter * 1 / 5), 
                    Offset(xMiddle + sin(secondRotation)* diameter,
                           yMiddle - cos(secondRotation) * diameter),
                    paint);

    // Draw inner red circle
    canvas.drawCircle(Offset(xMiddle,yMiddle), diameter / 20, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
