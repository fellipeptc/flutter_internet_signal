package br.com.prates.flutter_internet_signal

import android.annotation.TargetApi
import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkRequest
import android.net.wifi.WifiInfo
import android.net.wifi.WifiManager
import android.os.Build
import android.telephony.CellInfoCdma
import android.telephony.CellInfoGsm
import android.telephony.CellInfoLte
import android.telephony.TelephonyManager
import android.text.format.Formatter.formatIpAddress
import androidx.annotation.RequiresApi
import java.net.Inet4Address


class SignalStrengthHelper(private val context: Context) {

    @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR1)
    fun getMobileSignalStrength(): Int? {
        val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager ?: return null
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            telephonyManager.signalStrength?.cellSignalStrengths?.firstOrNull()?.dbm
        } else {
            val cells = telephonyManager.allCellInfo
            if (cells.isNullOrEmpty()) return null
            val strength = when (val cell = cells.first()) {
                is CellInfoGsm -> cell.cellSignalStrength.dbm
                is CellInfoCdma -> cell.cellSignalStrength.dbm
                is CellInfoLte -> cell.cellSignalStrength.dbm
                else -> null
            }
            if (strength != null && strength > 0) null else strength
        }
    }


    fun getWifiSignalStrength(): Int? {
        val wifiInfo: WifiInfo? = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            getWifiInfoFromConnectivityManager()
        } else {
            val wifiManager = context.applicationContext.getSystemService(Context.WIFI_SERVICE) as? WifiManager
            if (wifiManager?.isWifiEnabled == true) {
                wifiManager.connectionInfo
            } else null
        }
        return wifiInfo?.rssi
    }

    fun getWifiLinkSpeed(): Int? {
        val wifiInfo: WifiInfo? = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            getWifiInfoFromConnectivityManager()
        } else {
            val wifiManager = context.applicationContext.getSystemService(Context.WIFI_SERVICE) as? WifiManager
            if (wifiManager?.isWifiEnabled == true) {
                wifiManager.connectionInfo
            } else null
        }
        return wifiInfo?.linkSpeed
    }


    fun getWifiSsid(): String? {
        val wifiInfo: WifiInfo? = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            getWifiInfoFromConnectivityManager()
        } else {
            val wifiManager = context.applicationContext.getSystemService(Context.WIFI_SERVICE) as? WifiManager
            if (wifiManager?.isWifiEnabled == true) {
                wifiManager.connectionInfo
            } else null
        }
        return wifiInfo?.ssid
    }

    fun getWifiIpAddress(): String? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            getIpAddressFromConnectivityManager()
        } else {
            val wifiManager = context.applicationContext.getSystemService(Context.WIFI_SERVICE) as? WifiManager
            if (wifiManager?.isWifiEnabled == true) {
                val wifiInfo = wifiManager.connectionInfo
                val ip = wifiInfo?.ipAddress ?: return null
                return formatIpAddress(ip)
            }
            null
        }
    }


    @RequiresApi(Build.VERSION_CODES.S)
    private fun getWifiInfoFromConnectivityManager(): WifiInfo? {
        val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as? ConnectivityManager ?: return null
        val activeNetwork = connectivityManager.activeNetwork ?: return null
        val networkCapabilities = connectivityManager.getNetworkCapabilities(activeNetwork) ?: return null

        val transportInfo = networkCapabilities.transportInfo
        if (transportInfo is WifiInfo) {
            return transportInfo
        }
        return null
    }

    @RequiresApi(Build.VERSION_CODES.S)
    private fun getIpAddressFromConnectivityManager(): String? {
        val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as? ConnectivityManager ?: return null
        val activeNetwork = connectivityManager.activeNetwork ?: return null
        val linkProperties = connectivityManager.getLinkProperties(activeNetwork) ?: return null

        val addresses = linkProperties.linkAddresses
        for (linkAddress in addresses) {
            val address = linkAddress.address
            // Ignore ipv6 and localhost
            if (address is Inet4Address && !address.isLoopbackAddress) {
                return address.hostAddress
            }
        }
        return null
    }
}
