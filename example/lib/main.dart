import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_internet_signal/flutter_internet_signal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  int? _signalInternet;
  DateTime _now = DateTime.now();
  final _flutterInternetSignalPlugin = FlutterInternetSignal();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    loopGetInternet();
  }

  Future loopGetInternet() async {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 1000));
      int? signalInternet;
      try {
        signalInternet =
            await _flutterInternetSignalPlugin.getIntertSignalCellphone() ?? -1;
      } on PlatformException {
        if (kDebugMode) {
          print('Error get signal internet.');
          _signalInternet = null;
        }
      }
      setState(() {
        _now = DateTime.now();
        _signalInternet = signalInternet;
      });
    }
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion =
          await _flutterInternetSignalPlugin.getPlatformVersion() ??
              'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: $_platformVersion\n'),
              Text('On signal: ${_signalInternet ?? 'No connection'} [dBm]\n'),
              Text('Time: ${_now.hour}:${_now.minute}:${_now.second} \n'),
            ],
          ),
        ),
      ),
    );
  }
}
