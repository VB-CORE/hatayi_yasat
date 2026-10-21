import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:lifeclient/product/init/app_check/app_check_initialize.dart';

/// Firebase Console → App Check → Apps → Web altında kayıtlı reCAPTCHA Enterprise
/// site anahtarı. Paketle birlikte tarayıcıya indiği için gizli değildir; build
/// sırasında `--dart-define=RECAPTCHA_ENTERPRISE_SITE_KEY=...` ile verilir.
const _recaptchaSiteKey = String.fromEnvironment(
  'RECAPTCHA_ENTERPRISE_SITE_KEY',
);

/// Console → App Check → Apps → Manage debug tokens altına kaydedilmiş hata
/// ayıklama token'ı. Boşsa JS SDK kendi üretip tarayıcı konsoluna yazar.
const _debugToken = String.fromEnvironment('APP_CHECK_DEBUG_TOKEN');

final class PlatformAppCheckInitialize implements AppCheckInitialize {
  const PlatformAppCheckInitialize();

  @override
  Future<void> activate() async {
    final provider = _webProvider();
    if (provider == null) {
      return;
    }

    try {
      await FirebaseAppCheck.instance.activate(providerWeb: provider);
    } on Object {
      // Web hata kanalı WEB-35 (#516) ile açılana kadar sessiz geçilir; App Check
      // token'sız kalan istekler konsolda permission-denied olarak görünür.
    }
  }

  /// Hata ayıklamada debug provider kullanılır (token konsola kaydedilmeli).
  /// Yayında site anahtarı yoksa App Check hiç açılmaz; enforcement'ı bunu
  /// bilmeden açmak web'i kırar.
  WebProvider? _webProvider() {
    if (kDebugMode) {
      return _debugToken.isEmpty
          ? WebDebugProvider()
          : WebDebugProvider(debugToken: _debugToken);
    }

    return _recaptchaSiteKey.isEmpty
        ? null
        : ReCaptchaEnterpriseProvider(_recaptchaSiteKey);
  }
}
