import 'package:flutter/widgets.dart';

/// Haritanın üstüne çizilen widget. Mobilde harita native view'dır ve
/// Flutter katmanı zaten üsttedir; ek bir şey gerekmez.
final class MapOverlay extends StatelessWidget {
  const MapOverlay({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}
