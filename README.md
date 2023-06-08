# flutter_internet_signal_example

- [by: fellipe prates](https://github.com/fellipeptc)

A Flutter plugin for Android that get mobile signal network in dBm value.
The value in dBm is negative, so the better connection, the value is closer to 0.

|                | Android | iOS       |
|----------------|---------|-----------|
| **Support**    | SDK 17+ | under development |

### Android

Change the minimum Android sdk version to 17 (or higher) in your `android/app/build.gradle` file.

```groovy
minSdkVersion 17
```

Add permissions in your `manifest` file.

```groovy
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
```

## Example

<?code-excerpt "main.dart (AppLifecycle)"?>

```dart
import 'package:flutter_internet_signal/flutter_internet_signal.dart';

void main() async {
  final FlutterInternetSignal internetSignal = FlutterInternetSignal();
  final int? signal = await internetSignal.getMobileSignalStrength();
  print('Result dBm -> $signal');
}
```

For a more elaborate usage example, build and debug [main.dart](https://github.com/fellipeptc/flutter_internet_signal/blob/main/example/lib/main.dart)
