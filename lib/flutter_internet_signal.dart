import 'package:flutter_internet_signal/signal_info/wifi_signal_info.dart';
import 'flutter_internet_signal_platform_interface.dart';

class FlutterInternetSignal {
  /// Returns the current **mobile signal strength** in decibel-milliwatts (dBm).
  ///
  /// A lower (more negative) value indicates a weaker signal.
  /// Typical range: -30 (excellent) to -120 (very poor).
  ///
  /// Returns `null` if:
  /// - There is no active mobile connection
  /// - Missing permissions (e.g., `ACCESS_FINE_LOCATION`)
  /// - Device doesn't support it (min SDK < 17)
  ///
  /// ⚠️ Requires **Android API level 17** or higher.
  ///
  /// Example:
  /// ```dart
  /// final strength = await signal.getMobileSignalStrength();
  /// print('Mobile Signal: \$strength dBm');
  /// ```
  Future<int?> getMobileSignalStrength() {
    return FlutterInternetSignalPlatform.instance.getMobileSignalStrength();
  }

  @Deprecated(
      'Use getWifiSignalInfo() instead. This method will be removed in a future release.\n')
  Future<int?> getWifiSignalStrength() {
    return FlutterInternetSignalPlatform.instance.getWifiSignalStrength();
  }

  @Deprecated(
      'Use getWifiSignalInfo() instead. This method will be removed in a future release.\n')
  Future<int?> getWifiLinkSpeed() {
    return FlutterInternetSignalPlatform.instance.getWifiLinkSpeed();
  }

  /// Returns a snapshot of the current wifi signal information.
  ///
  /// This method combines:
  /// - Wi-Fi signal strength in dBm
  /// - Wi-Fi link speed in Mbps
  /// - Wi-Fi frequency in MHz
  /// - Wi-Fi ssid
  /// - Wi-Fi bssid
  /// - Wi-Fi ip address
  ///
  /// Returns a [WifiSignalInfo] object containing the available data, or `null`
  /// if no internet-related signal information could be retrieved.
  ///
  /// Example:
  /// ```dart
  /// final wifi = await FlutterInternetSignal().getWifiSignalInfo();
  ///
  /// if (info != null) {
  ///   print('Wi-Fi Signal: ${wifi.dbm} dBm');
  ///   print('Wi-Fi Speed: ${wifi.mbps} Mbps');
  /// } else {
  ///   print('No wifi signal information available.');
  /// }
  /// ```
  ///
  /// ⚠️ **Android only.**
  ///
  /// Permissions required:
  /// - For mobile signal: `READ_PHONE_STATE`
  /// - For Wi-Fi: `ACCESS_FINE_LOCATION` or `ACCESS_WIFI_STATE` depending on SDK
  ///
  /// Returns `null` fields inside [WifiSignalInfo] when data is unavailable.
  Future<WifiSignalInfo?> getWifiSignalInfo() {
    return FlutterInternetSignalPlatform.instance.getWifiSignalInfo();
  }
}
