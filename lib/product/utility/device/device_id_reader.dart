// Contract for the conditionally imported io/web implementations.
// ignore: one_member_abstracts
abstract interface class DeviceIdReader {
  /// Returns null when the platform exposes no stable hardware id.
  Future<String?> read();
}
