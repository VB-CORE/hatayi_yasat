import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:lifeclient/product/utility/constants/app_breakpoints.dart';
import 'package:responsive_builder/responsive_builder.dart';

enum AppScreenType {
  mobile,
  tablet,
  web;

  bool get isMobile => this == AppScreenType.mobile;
  bool get isTablet => this == AppScreenType.tablet;
  bool get isWeb => this == AppScreenType.web;
}

extension AppResponsiveContext on BuildContext {
  AppResponsive get responsive => AppResponsive._(this);
}

@immutable
final class AppResponsive {
  const AppResponsive._(this._context);

  static const ScreenBreakpoints _breakpoints = ScreenBreakpoints(
    desktop: double.infinity,
    tablet: AppBreakpoints.tablet,
    watch: 0,
  );

  final BuildContext _context;

  AppScreenType get screenType {
    final deviceType = getDeviceType(MediaQuery.sizeOf(_context), _breakpoints);
    if (deviceType != DeviceScreenType.tablet) return AppScreenType.mobile;
    return kIsWeb ? AppScreenType.web : AppScreenType.tablet;
  }

  T value<T>({required T mobile, T? tablet, T? web}) => switch (screenType) {
    AppScreenType.mobile => mobile,
    AppScreenType.tablet => tablet ?? mobile,
    AppScreenType.web => web ?? tablet ?? mobile,
  };
}
