import 'package:basic_clock/clockface.dart';
import 'package:basic_clock/pages/configscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
  //double transSecond =0.0;
  //double transMinute =0.0;
  Animation<double> animationSecond;
  AnimationController controllerSecond;

  @override
  void initState() {
    //now setup the aninmation events and methods
    controllerSecond = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    controllerSecond.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
      } else if (status == AnimationStatus.dismissed) {
        controllerSecond.forward();
      }
    });

    timer =
        new Timer.periodic(Duration(seconds: 1), (Timer t) => updateTime(t));
    updateTime(timer);
    loadTime();    
    animationSecond = Tween(begin: 0.0, end: 0.2).animate(controllerSecond)
      ..addListener(() {
          setState(() {
          });
      });    
    controllerSecond.forward();
    super.initState();
  }

  void loadTime() {
    timeNow = DateTime.now(); 
    hour = timeNow.hour;
    minute = timeNow.minute;
    second = timeNow.second;     
    //Now get the latest time
    timeNow = DateTime.now();
    hourString = timeNow.hour.toString().padLeft(2, '0');
    minuteString = timeNow.minute.toString().padLeft(2, '0');
    secondString = timeNow.second.toString().padLeft(2, '0');
    dateString = timeNow.day.toString();
    hour = timeNow.hour;
    minute = timeNow.minute;
    second = timeNow.second; 
  }

  void updateTime(Timer t) {
    loadTime();
    //start the aninmation
    controllerSecond.reset();

  }

  @override
  void dispose() {
    controllerSecond.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return PlatformScaffold(
      iosContentBottomPadding: false,
      iosContentPadding: false,
      backgroundColor: Colors.black,
      appBar: PlatformAppBar(
        trailingActions: [
          PlatformIconButton(
            iosIcon: Icon ( CupertinoIcons.info, size: 28.0,),
            androidIcon: Icon(Icons.info),
            //icon: Icon(Icons.info),
            //child: PlatformText('Config'),
            onPressed: () {  //Navigate to config screen when tapped
              Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigScreen()),
              );
            }
          ),
        ],
        title: PlatformText("My Clock"),
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
            height: 120,
            child: Text(
              hourString + ":" + minuteString, // + ":" + secondString,
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
          painter: ClockFace(hour, minute, second, animationSecond.value),
        ),
      ]),
    );
  }
}
