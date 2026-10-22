import 'package:firebase_crashlytics/firebase_crashlytics.dart';

abstract interface class CrashlyticsProvider {
  FirebaseCrashlytics? get instance;
}
