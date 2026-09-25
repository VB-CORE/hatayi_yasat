import 'package:flutter/widgets.dart';
import 'package:lifeclient/product/package/responsive/app_responsive.dart';

@immutable
final class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    required this.mobile,
    super.key,
    this.tablet,
    this.web,
  });

  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? web;

  @override
  Widget build(BuildContext context) {
    final builder = context.responsive.value(
      mobile: mobile,
      tablet: tablet,
      web: web,
    );
    return builder(context);
  }
}
