package br.com.prates.flutter_internet_signal

import android.content.Context
import android.os.Build
import android.telephony.CellInfoCdma
import android.telephony.CellInfoGsm
import android.telephony.CellInfoLte
import android.telephony.TelephonyManager

class SignalStrengthHelper(private val context: Context) {

    fun getSignalStrength(): Int? {
        val telephonyManager =
            context.getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
            val listCellInfo = telephonyManager?.allCellInfo
            if (!listCellInfo.isNullOrEmpty()) {
                return if (listCellInfo[0] is CellInfoGsm) {
                    val gsm = (listCellInfo[0] as CellInfoGsm).cellSignalStrength
                    gsm.dbm
                } else if (listCellInfo[0] is CellInfoCdma) {
                    val cdma = (listCellInfo[0] as CellInfoCdma).cellSignalStrength
                    cdma.dbm
                } else if (listCellInfo[0] is CellInfoLte) {
                    val lte = (listCellInfo[0] as CellInfoLte).cellSignalStrength
                    lte.dbm
                } else {
                    null
                }
            }
        }
        return null
    }
}
