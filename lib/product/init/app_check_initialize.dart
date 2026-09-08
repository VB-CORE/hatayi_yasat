import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// Attaches an App Check attestation token to Firestore, Storage and callable
/// requests so the backend can tell real builds from scripted traffic.
final class AppCheckInitialize {
  const AppCheckInitialize._();

  /// Activation is best effort: enforcement stays off in the Firebase console
  /// until adoption of this release is high enough, so a failure here costs
  /// nothing but a missing token and must never keep the app from starting.
  static Future<void> activate() async {
    try {
      await FirebaseAppCheck.instance.activate(
        providerAndroid: kDebugMode
            ? const AndroidDebugProvider()
            : const AndroidPlayIntegrityProvider(),
        providerApple: kDebugMode
            ? const AppleDebugProvider()
            : const AppleAppAttestWithDeviceCheckFallbackProvider(),
      );
    } on Object catch (error, stackTrace) {
      await FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
        reason: 'App Check activation failed',
      );
    }
  }
}
