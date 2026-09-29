import 'package:flutter/widgets.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

/// Haritanın üstüne çizilen widget. Web'de harita bir HTML elementidir ve
/// tıklamaları Flutter'dan önce yakalar; [PointerInterceptor] bunu engeller.
final class MapOverlay extends StatelessWidget {
  const MapOverlay({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => PointerInterceptor(child: child);
}
