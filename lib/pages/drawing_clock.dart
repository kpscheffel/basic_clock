import 'package:basic_clock/clockface.dart';
import 'package:basic_clock/pages/configscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

class DrawingClock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawingClockState();
  }
}

class DrawingClockState extends State<DrawingClock>
    with SingleTickerProviderStateMixin {
  Timer timer;
  DateTime timeNow;
  String hourString = '12';
  String minuteString = '00';
  String secondString = '00';
  String dateString = '31';
  int hour;
  int minute;
  int second;
  double transSecond =0.0;
  double transMinute =0.0;
  Animation<double> animationSecond;
  AnimationController controllerSecond;

  @override
  void initState() {
    super.initState();
    timeNow = DateTime.now(); 
    hour = timeNow.hour;
    minute = timeNow.minute;
    second = timeNow.second;     

    controllerSecond = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    controllerSecond.forward();

    controllerSecond.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controllerSecond.reset();
          //Now get the latest time
          timeNow = DateTime.now();
          hourString = timeNow.hour.toString().padLeft(2, '0');
          minuteString = timeNow.minute.toString().padLeft(2, '0');
          secondString = timeNow.second.toString().padLeft(2, '0');
          dateString = timeNow.day.toString();
          hour = timeNow.hour;
          minute = timeNow.minute;
          second = timeNow.second; 
      } else if (status == AnimationStatus.dismissed) {
        controllerSecond.forward();
      }
    });
  }

  @override
  void dispose() {
    controllerSecond.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationSecond = Tween(begin: 0.0, end: 1.0).animate(controllerSecond)
      ..addListener(() {
        setState(() {
          transSecond = animationSecond.value;
        });
      });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          RaisedButton(
            child: Text('Config'),
            onPressed: () {  //Navigate to config screen when tapped
              Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigScreen()),
              );
            }
          ),
        ],
        title: Text("My Clock"),
      ),
      body: Stack(children: [
        //Date location
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 5),
          child: Text(dateString,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              )),
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
          painter: ClockFace(hour, minute, second, transSecond, 0.0),
        ),
      ]),
    );
  }
}
