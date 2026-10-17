import 'dart:async';
import 'dart:js_interop';

import 'package:lifeclient/product/package/maps/maps_support.dart';
import 'package:web/web.dart' as web;

final class PlatformMapsSupport implements MapsSupport {
  const PlatformMapsSupport();

  static const String _apiKey = String.fromEnvironment('MAPS_WEB_API_KEY');

  @override
  Future<void> load() async {
    if (_apiKey.isEmpty) return;

    final loaded = Completer<void>();
    void complete(web.Event _) {
      if (!loaded.isCompleted) loaded.complete();
    }

    final script = web.HTMLScriptElement()
      ..src = 'https://maps.googleapis.com/maps/api/js?key=$_apiKey'
      ..onload = complete.toJS
      ..onerror = complete.toJS;
    web.document.head?.append(script);
    await loaded.future;
  }

  @override
  bool get supportsMyLocation => false;
}
