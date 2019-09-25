import 'package:basic_clock/clockface.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/rendering.dart';

class DrawingClock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawingClockState();
  }
}

class DrawingClockState extends State<DrawingClock> {
  Timer timer;
  DateTime timeNow;
  String hourString = '12';
  String minuteString = '00';
  String secondString = '00';
  String dateString = '31';
  int hour;
  int minute;
  int second;

  @override
  void initState() {
    timer =
        new Timer.periodic(Duration(seconds: 1), (Timer t) => updateTime(t));
    updateTime(timer);
    super.initState();
  }

  void updateTime(Timer t) {
    timeNow = DateTime.now();
//    print('update time $timeNow');
    setState(() {
      hourString = timeNow.hour.toString().padLeft(2, '0');
      minuteString = timeNow.minute.toString().padLeft(2, '0');
      secondString = timeNow.second.toString().padLeft(2, '0');
      dateString = timeNow.day.toString();
      hour = timeNow.hour;
      minute = timeNow.minute;
      second = timeNow.second;
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("My Clock"),
      ),
      body: Stack(children: [
        //Date location
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 5),
          child: Text(
            dateString,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white),
          ),
        ),
        // Clock at the bottom
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 130,
            child: Text(
              hourString + ":" + minuteString, // + ":" + second,
              style: TextStyle(
                fontSize: 70,
                color: Colors.white,
                fontFamily: "LCD",
              ),
            ),
          ),
        ),
        // Actual clock
        CustomPaint(
          size: MediaQuery.of(context).size,
          painter: ClockFace(hour, minute, second),
        ),
      ]),
    );
  }
}
