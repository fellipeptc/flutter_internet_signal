import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_internet_signal/signal_info/wifi_signal_info.dart';

import 'flutter_internet_signal_platform_interface.dart';

/// An implementation of [FlutterInternetSignalPlatform] that uses method channels.
class MethodChannelFlutterInternetSignal extends FlutterInternetSignalPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_internet_signal');

  @override
  Future<int?> getMobileSignalStrength() async {
    final signal =
        await methodChannel.invokeMethod<int?>('getMobileSignalStrength');
    return signal;
  }

  @override
  Future<WifiSignalInfo?> getWifiSignalInfo() async {
    if (await _isWifiEnabled() == false) return null;
    return WifiSignalInfo(
      dbm: await getWifiSignalStrength(),
      mbps: await getWifiLinkSpeed(),
      frequency: await _getWifiFrequency(),
      ssid: await _getWifiSsid(),
      bssid: await _getgetWifiBssid(),
      ipAddress: await _getWifiIpAddress(),
    );
  }

  @override
  Future<int?> getWifiSignalStrength() async {
    final wifiSignal =
        await methodChannel.invokeMethod<int?>('getWifiSignalStrength');
    return wifiSignal;
  }

  @override
  Future<int?> getWifiLinkSpeed() async {
    final speed = await methodChannel.invokeMethod<int?>('getWifiLinkSpeed');
    return speed;
  }

  Future<String?> _getWifiSsid() async {
    final ssid = await methodChannel.invokeMethod<String?>('getWifiSsid');
    return ssid;
  }

  Future<String?> _getgetWifiBssid() async {
    final bssid = await methodChannel.invokeMethod<String?>('getWifiBssid');
    return bssid;
  }

  Future<String?> _getWifiIpAddress() async {
    final ssid = await methodChannel.invokeMethod<String?>('getWifiIpAddress');
    return ssid;
  }

  Future<int?> _getWifiFrequency() async {
    final frequency =
        await methodChannel.invokeMethod<int?>('getWifiFrequency');
    return frequency;
  }

  Future<bool> _isWifiEnabled() async {
    return await methodChannel.invokeMethod<bool?>('isWifiEnabled') ?? false;
  }
}
