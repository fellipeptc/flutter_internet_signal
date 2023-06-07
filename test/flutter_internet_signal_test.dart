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
  Future<int?> getInternetSignal() {
    throw UnimplementedError();
  }
}

void main() {
  final FlutterInternetSignalPlatform initialPlatform = FlutterInternetSignalPlatform.instance;

  test('$MethodChannelFlutterInternetSignal is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterInternetSignal>());
  });

  test('getPlatformVersion', () async {
    FlutterInternetSignal flutterInternetSignalPlugin = FlutterInternetSignal();
    MockFlutterInternetSignalPlatform fakePlatform = MockFlutterInternetSignalPlatform();
    FlutterInternetSignalPlatform.instance = fakePlatform;

    expect(await flutterInternetSignalPlugin.getPlatformVersion(), '42');
  });
}