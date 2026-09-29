/// Google Maps'in platforma göre farklılaşan kısımları.
abstract interface class MapsSupport {
  /// Haritayı kullanmadan önce gereken SDK'yı yükler.
  Future<void> load();

  /// `GoogleMap.myLocationEnabled` bu platformda çalışıyor mu.
  bool get supportsMyLocation;
}
