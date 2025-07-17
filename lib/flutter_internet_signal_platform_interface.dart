import 'package:flutter_internet_signal/signal_info/wifi_signal_info.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_internet_signal_method_channel.dart';

abstract class FlutterInternetSignalPlatform extends PlatformInterface {
  /// Constructs a FlutterInternetSignalPlatform.
  FlutterInternetSignalPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterInternetSignalPlatform _instance = MethodChannelFlutterInternetSignal();

  /// The default instance of [FlutterInternetSignalPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterInternetSignal].
  static FlutterInternetSignalPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterInternetSignalPlatform] when
  /// they register themselves.
  static set instance(FlutterInternetSignalPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<int?> getMobileSignalStrength() {
    throw UnimplementedError('getMobileSignalStrength() has not been implemented.');
  }

  Future<int?> getWifiSignalStrength() {
    throw UnimplementedError('getWifiSignalStrength() has not been implemented.');
  }

  Future<int?> getWifiLinkSpeed() {
    throw UnimplementedError('getWifiLinkSpeed() has not been implemented.');
  }

  Future<WifiSignalInfo?> getWifiSignalInfo() {
    throw UnimplementedError('getWifiSignalInfo() has not been implemented.');
  }
}
