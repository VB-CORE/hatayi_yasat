import 'package:flutter/widgets.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

final class MapOverlay extends StatelessWidget {
  const MapOverlay({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => PointerInterceptor(child: child);
}
