import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:lifeclient/product/package/firebase/crashlytics/crashlytics_provider.dart';

final class PlatformCrashlyticsProvider implements CrashlyticsProvider {
  const PlatformCrashlyticsProvider();

  @override
  bool get isSupported => false;

  @override
  FirebaseCrashlytics? get instance => null;
}
