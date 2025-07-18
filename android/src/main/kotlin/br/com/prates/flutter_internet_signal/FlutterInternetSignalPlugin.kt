package br.com.prates.flutter_internet_signal

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterInternetSignalPlugin */
class FlutterInternetSignalPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var signalHelper: SignalHelper

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_internet_signal")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
        signalHelper = SignalHelper(context)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getMobileSignalStrength") {
            val mobileSignal = signalHelper.getMobileSignalStrength()
            result.success(mobileSignal)
        }
        if (call.method == "getWifiSignalStrength") {
            val wifiSignal = signalHelper.getWifiSignalStrength()
            result.success(wifiSignal)
        }
        if (call.method == "getWifiLinkSpeed") {
            val speed = signalHelper.getWifiLinkSpeed()
            result.success(speed)
        }
        if (call.method == "getWifiSsid") {
            val wifiSsid = signalHelper.getWifiSsid()
            result.success(wifiSsid)
        }
        if (call.method == "getWifiBssid") {
            val wifiBssid = signalHelper.getWifiBssid()
            result.success(wifiBssid)
        }
        if (call.method == "getWifiIpAddress") {
            val ipAddress = signalHelper.getWifiIpAddress()
            result.success(ipAddress)
        }
        if (call.method == "getWifiFrequency") {
            val frequency = signalHelper.getWifiFrequency()
            result.success(frequency)
        }
        if (call.method == "isWifiEnabled") {
            val isWifiEnabled = signalHelper.isWifiEnabled()
            result.success(isWifiEnabled)
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
