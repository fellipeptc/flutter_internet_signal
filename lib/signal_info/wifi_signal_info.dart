class WifiSignalInfo {
  final int? dbm;
  final int? mbps;
  final int? frequency;
  final String? ssid;
  final String? bssid;
  final String? ipAddress;

  const WifiSignalInfo({
    this.dbm,
    this.mbps,
    this.frequency,
    this.ssid,
    this.bssid,
    this.ipAddress,
  });

  @override
  String toString() {
    return 'WifiSignalInfo(dbm: $dbm, mbps: $mbps, frequency: $frequency, ssid: $ssid, bssid: $bssid, ipAddress: $ipAddress)';
  }

  @override
  bool operator ==(covariant WifiSignalInfo other) {
    if (identical(this, other)) return true;

    return other.dbm == dbm &&
        other.mbps == mbps &&
        other.frequency == frequency &&
        other.ssid == ssid &&
        other.bssid == bssid &&
        other.ipAddress == ipAddress;
  }

  @override
  int get hashCode {
    return dbm.hashCode ^
        mbps.hashCode ^
        frequency.hashCode ^
        ssid.hashCode ^
        bssid.hashCode ^
        ipAddress.hashCode;
  }
}
