import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_internet_signal/flutter_internet_signal.dart';
import 'package:flutter_internet_signal/flutter_internet_signal_platform_interface.dart';
import 'package:flutter_internet_signal/flutter_internet_signal_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterInternetSignalPlatform
    with MockPlatformInterfaceMixin
    implements FlutterInternetSignalPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<int?> getMobileSignalStrength() => Future.value(-100);

  @override
  Future<int?> getWifiSignalStrength() => Future.value(-100);

  @override
  Future<int?> getWifiLinkSpeed() => Future.value(250);
}

void main() {
  final FlutterInternetSignalPlatform initialPlatform =
      FlutterInternetSignalPlatform.instance;

  test('$MethodChannelFlutterInternetSignal is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterInternetSignal>());
  });

  test('getPlatformVersion', () async {
    FlutterInternetSignal flutterInternetSignalPlugin = FlutterInternetSignal();
    MockFlutterInternetSignalPlatform fakePlatform =
        MockFlutterInternetSignalPlatform();
    FlutterInternetSignalPlatform.instance = fakePlatform;

    expect(await flutterInternetSignalPlugin.getPlatformVersion(), '42');
  });

  test('getMobileSignalStrength', () async {
    FlutterInternetSignal flutterInternetSignalPlugin = FlutterInternetSignal();
    MockFlutterInternetSignalPlatform fakePlatform =
        MockFlutterInternetSignalPlatform();
    FlutterInternetSignalPlatform.instance = fakePlatform;

    expect(await flutterInternetSignalPlugin.getMobileSignalStrength(), -100);
  });

  test('getWifiSignalStrength', () async {
    FlutterInternetSignal flutterInternetSignalPlugin = FlutterInternetSignal();
    MockFlutterInternetSignalPlatform fakePlatform =
        MockFlutterInternetSignalPlatform();
    FlutterInternetSignalPlatform.instance = fakePlatform;

    expect(await flutterInternetSignalPlugin.getWifiSignalStrength(), -100);
  });

  test('getWifiLinkSpeed', () async {
    FlutterInternetSignal flutterInternetSignalPlugin = FlutterInternetSignal();
    MockFlutterInternetSignalPlatform fakePlatform =
        MockFlutterInternetSignalPlatform();
    FlutterInternetSignalPlatform.instance = fakePlatform;

    expect(await flutterInternetSignalPlugin.getWifiLinkSpeed(), 250);
  });
}
