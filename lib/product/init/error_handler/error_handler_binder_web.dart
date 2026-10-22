import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/product/init/error_handler/error_handler_binder.dart';
import 'package:web/web.dart' as web;

final class PlatformErrorHandlerBinder implements ErrorHandlerBinder {
  const PlatformErrorHandlerBinder();

  @override
  void bind() {
    FlutterError.onError = (errorDetails) {
      FlutterError.presentError(errorDetails);
      _report(
        errorDetails.exception,
        errorDetails.stack,
        reason: errorDetails.context?.toDescription(),
      );
    };

    web.window
      ..addEventListener('error', _onWindowError.toJS)
      ..addEventListener('unhandledrejection', _onUnhandledRejection.toJS);
  }

  static void _onWindowError(web.ErrorEvent event) {
    _report(
      event.message,
      StackTrace.fromString('${event.filename}:${event.lineno}:${event.colno}'),
      reason: 'window_error',
    );
  }

  static void _onUnhandledRejection(web.PromiseRejectionEvent event) {
    _report(
      event.reason.dartify()?.toString() ?? 'unknown',
      null,
      reason: 'unhandled_rejection',
    );
  }

  static void _report(Object error, StackTrace? stack, {String? reason}) {
    try {
      ProjectDependencyItems.analyticsService.recordError(
        error,
        stack,
        fatal: true,
        reason: reason,
      );
    } on Object catch (reportError) {
      debugPrint('$reportError');
    }
  }
}
