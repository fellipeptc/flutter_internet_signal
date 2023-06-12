import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_internet_signal_platform_interface.dart';

/// An implementation of [FlutterInternetSignalPlatform] that uses method channels.
class MethodChannelFlutterInternetSignal extends FlutterInternetSignalPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_internet_signal');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<int?> getMobileSignalStrength() async {
    final signal =
        await methodChannel.invokeMethod<int?>('getMobileSignalStrength');
    return signal;
  }

  @override
  Future<int?> getWifiSignalStrength() async {
    final signal =
        await methodChannel.invokeMethod<int?>('getWifiSignalStrength');
    return signal;
  }

  @override
  Future<int?> getWifiLinkSpeed() async {
    final speed = await methodChannel.invokeMethod<int?>('getWifiLinkSpeed');
    return speed;
  }
}
