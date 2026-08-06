import 'package:flutter/widgets.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/constants/regex_types.dart';

@immutable
final class AnalyticsRouteName {
  const AnalyticsRouteName._();

  static const String _unknown = 'unknown';

  /// go_router names a page `state.name ?? state.path`, so screens reach the
  /// observer either as a route name (`'Place Detail'`) or as a raw path
  /// (`'/main'`). Folding both into snake_case keeps GA4 on one naming scheme
  /// without touching the route `name:` values navigation relies on.
  static String extract(RouteSettings settings) {
    final raw = settings.name;
    if (raw == null || raw.isEmpty) return _unknown;

    final normalized = _normalize(raw);
    // The root path normalises to nothing once its separators are stripped.
    return normalized.isEmpty ? _normalize(SplashRoute.routeName) : normalized;
  }

  static String _normalize(String raw) {
    return raw
        .replaceAll(RegexTypes.routePathParameter, '')
        .replaceAll(RegexTypes.pathSeparators, ' ')
        .replaceAllMapped(
          RegexTypes.camelCaseBoundary,
          (match) => '${match[1]} ${match[2]}',
        )
        .trim()
        .toLowerCase()
        .replaceAll(RegexTypes.whitespace, '_');
  }
}
