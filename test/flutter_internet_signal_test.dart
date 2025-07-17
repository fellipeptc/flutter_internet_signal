import 'package:flutter_internet_signal/signal_info/wifi_signal_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_internet_signal/flutter_internet_signal.dart';
import 'package:flutter_internet_signal/flutter_internet_signal_platform_interface.dart';
import 'package:flutter_internet_signal/flutter_internet_signal_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterInternetSignalPlatform with MockPlatformInterfaceMixin implements FlutterInternetSignalPlatform {
  @override
  Future<int?> getMobileSignalStrength() => Future.value(-100);

  @override
  Future<int?> getWifiSignalStrength() => Future.value(-100);

  @override
  Future<int?> getWifiLinkSpeed() => Future.value(250);

  @override
  Future<WifiSignalInfo?> getWifiSignalInfo() => Future.value(WifiSignalInfo());
}

void main() {
  final FlutterInternetSignalPlatform initialPlatform = FlutterInternetSignalPlatform.instance;

  test('$MethodChannelFlutterInternetSignal is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterInternetSignal>());
  });

  test('getMobileSignalStrength', () async {
    FlutterInternetSignal flutterInternetSignalPlugin = FlutterInternetSignal();
    MockFlutterInternetSignalPlatform fakePlatform = MockFlutterInternetSignalPlatform();
    FlutterInternetSignalPlatform.instance = fakePlatform;

    expect(await flutterInternetSignalPlugin.getMobileSignalStrength(), -100);
  });

  test('getWifiSignalInfo', () async {
    FlutterInternetSignal flutterInternetSignalPlugin = FlutterInternetSignal();
    MockFlutterInternetSignalPlatform fakePlatform = MockFlutterInternetSignalPlatform();
    FlutterInternetSignalPlatform.instance = fakePlatform;

    expect(await flutterInternetSignalPlugin.getWifiSignalInfo(), WifiSignalInfo());
  });
}
