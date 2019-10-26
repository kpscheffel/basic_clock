import 'package:basic_clock/pages/drawing_clock.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(MyApp());
    });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Clock",
      home: DrawingClock(),
      debugShowCheckedModeBanner: false,
    );
  }
}
