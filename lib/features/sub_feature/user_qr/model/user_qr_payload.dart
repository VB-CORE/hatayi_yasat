abstract final class UserQrPayload {
  const UserQrPayload._();

  static const String _prefix = 'hatayiyasat://user/';

  static String encode(String uid) => '$_prefix$uid';

  static String? decode(String? raw) {
    final value = raw?.trim();
    if (value == null || value.isEmpty) return null;
    if (!value.startsWith(_prefix)) return null;
    final uid = value.substring(_prefix.length);
    return uid.isEmpty ? null : uid;
  }
}
