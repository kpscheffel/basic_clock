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
  Timer initTimer; 
  DateTime timeNow;
  String hourString = '12';
  String minuteString = '00';
  String secondString = '00';
  String dateString = '31';
  int hour;
  int minute;
  int second;
  int millisecond;
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

    loadTime();
    //Run timer to get to the start of a second   
//    print("load initial timer for $millisecond wait for  ${1000 - millisecond}");
    //Adjust start time of tick. If under 100 miliseconds then the time is good.
    if (millisecond > 100) {
      initTimer = new Timer.periodic(Duration(milliseconds: 1000 - millisecond), 
          (Timer t) => updateInitTime(t));
    } else {
      new Timer.periodic(Duration(seconds: 1), (Timer t) => updateTime(t));      
    }
    animationSecond = Tween(begin: 0.0, end: 0.2).animate(controllerSecond)
      ..addListener(() {
          setState(() {
          });
      });    
    controllerSecond.forward();
    super.initState();
  }

  void loadTime() {
    //Now get the latest time
    timeNow = DateTime.now(); 
    hour = timeNow.hour;
    minute = timeNow.minute;
    second = timeNow.second;  
    millisecond = timeNow.millisecond;   
//    print("Milliseconds = $millisecond");
//    print("Seconds = $second");
    hourString = timeNow.hour.toString().padLeft(2, '0');
    minuteString = timeNow.minute.toString().padLeft(2, '0');
    secondString = timeNow.second.toString().padLeft(2, '0');
    dateString = timeNow.day.toString();
    hour = timeNow.hour;
    minute = timeNow.minute;
    second = timeNow.second; 
  }

  void updateInitTime(Timer t) {
    //Setup the minute based timer now that we are at the beinging of a minute
    initTimer.cancel();
//    print("should only be called once");
    new Timer.periodic(Duration(seconds: 1), (Timer t) => updateTime(t));
    loadTime();    
  }

  void updateTime(Timer t) {
    //Time should now be accurate, now we can go with one seconds increments.
    loadTime();
    //start the aninmation
    controllerSecond.reset();
  }

  @override
  void dispose() {
    controllerSecond.dispose();
    initTimer.cancel();
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
