import 'package:flutter/material.dart';
import 'package:screen/screen.dart';

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