import 'package:firebase_crashlytics/firebase_crashlytics.dart';

abstract interface class CrashlyticsProvider {
  bool get isSupported;

  FirebaseCrashlytics? get instance;
}
