import 'package:basic_clock/pages/drawing_clock.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Clock",
      home: DrawingClock(),
      theme: ThemeData(fontFamily: "Raleway"),
    );
  }
}
