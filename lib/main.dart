import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'pages/drawing_clock.dart';
//import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

mixin PortraitModeMixin on StatelessWidget {
  /// blocks rotation; sets orientation to: portrait
  void portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // }  @override
    //   Widget build(BuildContext context) {
    //     _portraitModeOnly();
    //     return null;
    //   }
  }
}

class MyApp extends StatelessWidget with PortraitModeMixin {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    portraitModeOnly();
    WakelockPlus.enable();
    //    Screen.keepOn(true);
    return MaterialApp(
      title: 'Basic Clock',
      home: const DrawingClock(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
      ],
    );
  }
}
