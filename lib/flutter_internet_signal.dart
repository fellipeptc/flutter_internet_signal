import 'flutter_internet_signal_platform_interface.dart';

class FlutterInternetSignal {
  Future<String?> getPlatformVersion() {
    return FlutterInternetSignalPlatform.instance.getPlatformVersion();
  }

  Future<int?> getIntertSignalCellphone() {
    return FlutterInternetSignalPlatform.instance.getInternetSignal();
  }
}
