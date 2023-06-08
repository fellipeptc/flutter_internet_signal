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
  int? _mobileSignal;
  String? _version;
  DateTime _now = DateTime.now();
  final _flutterInternetSignalPlugin = FlutterInternetSignal();

  @override
  void initState() {
    super.initState();
    _timer();
    _getPlatformVersion();
  }

  Future<void> _getPlatformVersion() async {
    try {
      _version = await _flutterInternetSignalPlugin.getPlatformVersion();
    } on PlatformException {
      if (kDebugMode) {
        print('Error get mobile signal dBm.');
        _version = null;
      }
    }
  }

  Future _timer() async {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 1000));
      setState(() {
        _now = DateTime.now();
      });
    }
  }

  Future<void> _getMobileSignalStrength() async {
    int? mobile;
    try {
      mobile = await _flutterInternetSignalPlugin.getMobileSignalStrength();
    } on PlatformException {
      if (kDebugMode) {
        print('Error get mobile signal dBm.');
        _mobileSignal = null;
      }
    }
    setState(() {
      _mobileSignal = mobile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Internet Signal Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('On Version: $_version'),
              Text('On signal: ${_mobileSignal ?? 'No result'} [dBm]\n'),
              Text('Time: ${_now.hour}:${_now.minute}:${_now.second} \n'),
              ElevatedButton(
                onPressed: _getMobileSignalStrength,
                child: const Text('Get mobile signal'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
