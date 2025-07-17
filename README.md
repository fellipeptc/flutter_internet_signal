# Flutter Internet Signal

- [by: Fellipe Prates](https://github.com/fellipeptc)

A Flutter plugin for **Android** to retrieve **mobile** and **Wi-Fi** signal information.

Returns the received signal strength indicator (RSSI) of the current network in **dBm**.  
The dBm value is negative — the closer to 0, the better the signal (e.g., -30 is excellent, -100 is poor).

## ✨ New method - getWifiSignalInfo()

- Deprecated: getWifiSignalStrength() and getWifiLinkSpeed()
- New: getWifiLinkSpeed() method returns the class WifiSignalInfo.

| Property  | Type      | Description                             |
|-----------|-----------|-----------------------------------------|
| `dbm`     | `int?`    | Wi-Fi signal strength (in dBm)          |
| `mbps`    | `int?`    | Wi-Fi link speed (in Mbps)              |
| `ssid`    | `String?` | Wi-Fi network name (SSID)               |
| `bssid`   | `String?` | MAC address of the access point (BSSID) |
| `ip`      | `String?` | Local IP address                        |

|                | Android | iOS       |
|----------------|---------|-----------|
| **Support**    | SDK 17+ | under development |

### Android

Change the minimum Android sdk version to 17 (or higher) in your `android/app/build.gradle` file.

```groovy
minSdkVersion 17
```

Add permissions in your `manifest` file for mobile and wifi network:

```groovy
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

## Example

<?code-excerpt "main.dart (AppLifecycle)"?>

```dart
import 'package:flutter_internet_signal/flutter_internet_signal.dart';

void main() async {
  final FlutterInternetSignal internetSignal = FlutterInternetSignal();
  final int? mobileSignal = await internetSignal.getMobileSignalStrength();
  final WifiSignalInfo? wifiSignal = await internetSignal.getWifiSignalInfo();
  print('Result dBm -> $mobileSignal');
  print('Result wifi info -> ${wifiSignal.toString()}');
}
```

For a more elaborate usage example, build and debug [main.dart](https://github.com/fellipeptc/flutter_internet_signal/blob/main/example/lib/main.dart)
