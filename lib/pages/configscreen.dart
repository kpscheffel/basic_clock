import 'package:flutter/material.dart';
import 'package:screen/screen.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      iosContentPadding: true,
      appBar: PlatformAppBar(
        title: PlatformText("Configure Basic Clock"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
/*           PlatformButton(
          onPressed: () {
            //Navigagte back to first route (screen) when tapped
            Navigator.pop(context);
          },
          child: PlatformText('Go back!') ,

          ),
      ),
*/

              PlatformText(
                "Always on",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              new PlatformSwitch(
                value: _isKeptOn,
                onChanged: (bool newValue) {
                  _onChanged(newValue);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
