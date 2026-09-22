import 'dart:async';
import 'dart:isolate';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:lifeclient/product/init/error_handler/error_handler_binder.dart';

final class PlatformErrorHandlerBinder implements ErrorHandlerBinder {
  const PlatformErrorHandlerBinder();

  @override
  void bind() {
    FlutterError.onError = (errorDetails) {
      // Without this the console stack trace and red error screen are lost.
      FlutterError.presentError(errorDetails);
      unawaited(
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails),
      );
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      unawaited(
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
      );
      return true;
    };

    Isolate.current.addErrorListener(
      RawReceivePort((List<dynamic> pair) {
        final [error as Object, stack as String] = pair;
        unawaited(
          FirebaseCrashlytics.instance.recordError(
            error,
            StackTrace.fromString(stack),
            fatal: true,
          ),
        );
      }).sendPort,
    );
  }
}
