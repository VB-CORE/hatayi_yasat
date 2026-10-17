import 'package:flutter/widgets.dart';

/// Tells pages under `WebShell` whether the web sidebar is taking over the
/// main navigation. Absent on mobile, where [hasSidebar] always returns false.
final class WebLayoutScope extends InheritedWidget {
  const WebLayoutScope({
    required this.isSidebarVisible,
    required super.child,
    super.key,
  });

  final bool isSidebarVisible;

  static bool hasSidebar(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<WebLayoutScope>()
          ?.isSidebarVisible ??
      false;

  @override
  bool updateShouldNotify(WebLayoutScope oldWidget) =>
      isSidebarVisible != oldWidget.isSidebarVisible;
}
