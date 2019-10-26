import 'package:flutter/material.dart';
import 'package:screen/screen.dart';


class ConfigScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConfigScreenState();
  }
}

class ConfigScreenState extends State<ConfigScreen> {

  bool _configValue = false;

  ConfigScreenState() {
    _configValue = false;//await Screen.isKeptOn;
  }


  void _onChanged(bool value) {
    setState(() {
      _configValue = value;
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
        value: _configValue,
        onChanged: (bool newValue) {
          _onChanged(newValue);
        },
      )
      
      ],)
    );
  }
}