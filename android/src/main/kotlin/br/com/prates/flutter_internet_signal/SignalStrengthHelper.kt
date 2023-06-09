package br.com.prates.flutter_internet_signal

import android.content.Context
import android.net.wifi.WifiInfo
import android.net.wifi.WifiManager
import android.os.Build
import android.telephony.CellInfoCdma
import android.telephony.CellInfoGsm
import android.telephony.CellInfoLte
import android.telephony.TelephonyManager


class SignalStrengthHelper(private val context: Context) {

    fun getMobileSignalStrength(): Int? {
        val telephonyManager =
            context.getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            val signalStrength = telephonyManager?.signalStrength
            if (signalStrength != null) {
                val cellSignalStrengths = signalStrength.cellSignalStrengths
                if (cellSignalStrengths.isNotEmpty()) {
                    return cellSignalStrengths[0].dbm
                }
            }
            return null
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
            val listCellInfo = telephonyManager?.allCellInfo
            if (!listCellInfo.isNullOrEmpty()) {
                if (listCellInfo[0] is CellInfoGsm) {
                    val gsm = (listCellInfo[0] as CellInfoGsm).cellSignalStrength
                    if (gsm.dbm > 0) return null
                    return gsm.dbm
                }
                if (listCellInfo[0] is CellInfoCdma) {
                    val cdma = (listCellInfo[0] as CellInfoCdma).cellSignalStrength
                    if (cdma.dbm > 0) return null
                    return cdma.dbm
                }
                if (listCellInfo[0] is CellInfoLte) {
                    val lte = (listCellInfo[0] as CellInfoLte).cellSignalStrength
                    if (lte.dbm > 0) return null
                    return lte.dbm
                }
                return null
            }
        }
        return null
    }

    fun getWifiSignalStrength(): Int? {
        val wifiManager =
            context.applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
        if (wifiManager.isWifiEnabled) {
            val wifiInfo: WifiInfo? = wifiManager.connectionInfo
            if (wifiInfo != null) {
                return wifiInfo.rssi
            }
        }
        return null
    }

    fun getWifiLinkSpeed(): Int? {
        val wifiManager =
            context.applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
        if (wifiManager.isWifiEnabled) {
            val wifiInfo: WifiInfo? = wifiManager.connectionInfo
            if (wifiInfo != null) return wifiInfo.linkSpeed
        }
        return null
    }
}
