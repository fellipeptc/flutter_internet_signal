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
  Future<int?> getInternetSignal() async {
    final singal = await methodChannel.invokeMethod<int?>('getInternetSignal');
    return singal;
  }
}
