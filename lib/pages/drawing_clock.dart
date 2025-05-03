import '../clockface.dart';
import 'configscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class DrawingClock extends StatefulWidget {
  const DrawingClock({super.key});
  @override
  State<StatefulWidget> createState() {
    return DrawingClockState();
  }
}

class DrawingClockState extends State<DrawingClock>
    with SingleTickerProviderStateMixin {
  late Timer timer;
  late Timer initTimer;
  late DateTime timeNow;
  String hourString = '12';
  String minuteString = '00';
  String secondString = '00';
  String dateString = '31';
  late int hour;
  late int minute;
  late int second;
  late int millisecond;
  //double transSecond =0.0;
  //double transMinute =0.0;
  late Animation<double> animationSecond;
  late AnimationController controllerSecond;

  @override
  void initState() {
    //now setup the aninmation events and methods
    controllerSecond = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    controllerSecond.addStatusListener((AnimationStatus status) {
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
      initTimer = Timer.periodic(
        Duration(milliseconds: 1000 - millisecond),
        (Timer t) => updateInitTime(t),
      );
    } else {
      Timer.periodic(const Duration(seconds: 1), (Timer t) => updateTime(t));
    }
    animationSecond = Tween(begin: 0.0, end: 0.2).animate(controllerSecond)
      ..addListener(() {
        setState(() {});
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
    Timer.periodic(const Duration(seconds: 1), (Timer t) => updateTime(t));
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
      iosContentPadding: false,
      backgroundColor: Colors.black,
      appBar: PlatformAppBar(
        trailingActions: [
          PlatformIconButton(
            cupertinoIcon: const Icon(CupertinoIcons.info, size: 28.0),
            materialIcon: const Icon(Icons.info),
            //icon: Icon(Icons.info),
            //child: PlatformText('Config'),
            onPressed: () {
              //Navigate to config screen when tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ConfigScreen(),
                ),
              );
            },
          ),
        ],
        title: PlatformText('Basic Clock'),
      ),
      body: Stack(
        children: [
          //Date location
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 5),
            child: Text(
              dateString,
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          // Clock at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 120,
              child: Text(
                '$hourString:$minuteString', //:$secondString',
                style: const TextStyle(
                  fontSize: 70,
                  color: Colors.white,
                  fontFamily: 'LCD',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2.0,
                  height: 1.0,
                ),
              ),
            ),
          ),
          // Actual clock
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: ClockFace(hour, minute, second - 1, animationSecond.value),
          ),
        ],
      ),
    );
  }
}
