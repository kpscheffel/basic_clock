import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
// import 'package:screen/screen.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});
  @override
  State<ConfigScreen> createState() => _ConfigScreenState();

  //  State<StatefulWidget> createState() {
  //    return ConfigScreenState();
  //  }
}

class _ConfigScreenState extends State<ConfigScreen> {
  bool _isKeptOn = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  Future<void> _initPlatformState() async {
    try {
      final bool keptOn = await WakelockPlus.enabled;
      if (mounted) {
        setState(() {
          _isKeptOn = keptOn;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _onChanged(bool value) async {
    setState(() {
      _isKeptOn = value;
    });

    try {
      if (value) {
        await WakelockPlus.enable();
      } else {
        await WakelockPlus.disable();
      }
    } catch (e) {
      // Revert the switch state if the operation failed
      if (mounted) {
        setState(() {
          _isKeptOn = !value;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      iosContentPadding: true,
      appBar: PlatformAppBar(title: PlatformText('Configure Basic Clock')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              PlatformText('Always on', style: const TextStyle(fontSize: 24)),
              if (_isLoading)
                PlatformCircularProgressIndicator()
              else
                PlatformSwitch(value: _isKeptOn, onChanged: _onChanged),
            ],
          ),
        ),
      ),
    );
  }
}
