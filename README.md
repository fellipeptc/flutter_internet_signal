# Flutter Internet Signal

- [by: Fellipe Prates](https://github.com/fellipeptc)

A Flutter plugin for Android that get **mobile** and **wifi** signal network.
Returns the received signal strength indicator of the current 802.11 network, in dBm.
The value in dBm is negative, so the better connection, the value is closer to 0.

- New: getWifiLinkSpeed() method returns the speed indicator wifi network, in Mpbs.

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
  final int? wifiSignal = await internetSignal.getWifiSignalStrength();
  print('Result dBm -> $mobileSignal');
  print('Result dBm -> $wifiSignal');
}
```

For a more elaborate usage example, build and debug [main.dart](https://github.com/fellipeptc/flutter_internet_signal/blob/main/example/lib/main.dart)
