import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_internet_signal/flutter_internet_signal.dart';
import 'package:flutter_internet_signal/signal_info/wifi_signal_info.dart';
import 'package:flutter_internet_signal_example/signal_chart.dart';

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

  Timer? _pollingTimer;
  StreamController<WifiSignalInfo?>? _wifiSignalController;
  Stream<WifiSignalInfo?> get wifiSignalStream => _wifiSignalController!.stream;

  final List<double> _wifiSignalHistory = [];
  static const int _maxHistory = 30;

  final _internetSignal = FlutterInternetSignal();

  @override
  void initState() {
    super.initState();
    _wifiSignalController = StreamController<WifiSignalInfo?>.broadcast();
    _startSignalStream();
  }

  void _startSignalStream() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 1), (_) async {
      try {
        final wifi = await _internetSignal.getWifiSignalInfo();

        if (wifi?.dbm != null) {
          setState(() {
            _wifiSignalHistory.add(wifi!.dbm!.toDouble());

            if (_wifiSignalHistory.length > _maxHistory) {
              _wifiSignalHistory.removeAt(0);
            }
          });
        }

        _wifiSignalController?.add(wifi);
      } catch (e) {
        if (kDebugMode) print('Error open signal: $e');
      }
    });
  }

  Future<void> _getMobileSignal() async {
    try {
      final mobile = await _internetSignal.getMobileSignalStrength();
      setState(() {
        _mobileSignal = mobile;
      });
    } on PlatformException {
      if (kDebugMode) print('Error get mobile signal.');
    }
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    _wifiSignalController?.close();
    super.dispose();
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
              Text('Mobile signal: ${_mobileSignal ?? '--'} [dBm]\n'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _getMobileSignal,
                child: const Text('Get mobile signal'),
              ),
              SizedBox(height: 16),
              StreamBuilder<WifiSignalInfo?>(
                stream: wifiSignalStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const CircularProgressIndicator();
                  final signal = snapshot.data;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('STREAM - Timer periodic 1 second\n'),
                      Text('Wifi signal: ${signal?.dbm ?? '--'} [dBm]\n'),
                      const SizedBox(height: 12),
                      SignalChart(values: _wifiSignalHistory),
                      const SizedBox(height: 12),
                      Text('Wifi speed: ${signal?.mbps ?? '--'} [Mbps]\n'),
                      Text('Wifi frequency: ${signal?.frequency ?? '--'} [Mhz]\n'),
                      Text('Wifi ssid: ${signal?.ssid ?? '--'}\n'),
                      Text('Wifi bssid: ${signal?.bssid ?? '--'}\n'),
                      Text('Wifi IP: ${signal?.ipAddress ?? '--'}\n'),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
