import 'package:flutter/material.dart';
import 'package:screen/screen.dart';
import "dart:async";


class ConfigScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConfigScreenState();
  }
}

class ConfigScreenState extends State<ConfigScreen> {

  bool _isKeptOn = false;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    bool keptOn = await Screen.isKeptOn;
    setState(() {
      _isKeptOn = keptOn;
    });
  }

  void _onChanged(bool value) {
    setState(() {
      Screen.keepOn(value);      
      _isKeptOn = value;
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configure Basic Clock"),
      ),
      body: Row(children: <Widget>[
       Center(
        child: RaisedButton(
          onPressed: () {
            //Navigagte back to first route (screen) when tapped
            Navigator.pop(context);
          },
          child: Text('Go back!') ,
          ),
      ),
      Text("Alway on"),
      new Switch(
        value: _isKeptOn,
        onChanged: (bool newValue) {
          _onChanged(newValue);
        },
      )
      
      ],)
    );
  }
}

class ScreenValue {
  bool _value;

  ScreenValue._();

  static Future<ScreenValue> create() async {
    var result = ScreenValue._();
    await result._load();
    return result;
  }
  Future<void> _load() async {
    _value = await Screen.isKeptOn;
  }
  bool get value => _value;
}