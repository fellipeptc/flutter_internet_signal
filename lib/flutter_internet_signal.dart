import 'flutter_internet_signal_platform_interface.dart';

class FlutterInternetSignal {
  /// Get platform version Android.
  ///
  /// Returns String or null.
  ///
  Future<String?> getPlatformVersion() {
    return FlutterInternetSignalPlatform.instance.getPlatformVersion();
  }

  /// Returns mobile signal strength in dBm value **[int]** negative.
  ///
  /// Returns **null** if there is no connection or permission.
  ///
  /// Require Android SDK_MIN >= 17.
  ///
  Future<int?> getMobileSignalStrength() {
    return FlutterInternetSignalPlatform.instance.getMobileSignalStrength();
  }

  /// Returns wifi signal strength in dBm value **[int]** negative.
  ///
  /// Returns **null** if there is no connection or permission.
  ///
  Future<int?> getWifiSignalStrength() {
    return FlutterInternetSignalPlatform.instance.getWifiSignalStrength();
  }

  /// Returns wifi speed in Mbps value **[int]**.
  ///
  /// Returns **null** if there is no connection or permission.
  ///
  Future<int?> getWifiLinkSpeed() {
    return FlutterInternetSignalPlatform.instance.getWifiLinkSpeed();
  }
}
