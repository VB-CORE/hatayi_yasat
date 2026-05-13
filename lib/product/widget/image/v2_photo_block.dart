import 'package:flutter/material.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';

/// Mosaic-tinted placeholder photo block (1, 2, or 3 tiles).
///
/// Mirrors the V2 design `V2Photos` — uses the post's accent gradient
/// with a faint tile texture to evoke the mosaic identity until real
/// photo assets are wired in.
class V2PhotoBlock extends StatelessWidget {
  const V2PhotoBlock({
    required this.count,
    required this.accent,
    super.key,
  });

  final int count;
  final List<Color> accent;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();
    if (count == 1) {
      return _Tile(accent: accent, height: 220);
    }
    if (count == 2) {
      return Row(
        children: [
          Expanded(child: _Tile(accent: accent, height: 180)),
          const SizedBox(width: 6),
          Expanded(
            child: _Tile(accent: accent.reversed.toList(), height: 180),
          ),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(flex: 2, child: _Tile(accent: accent, height: 220)),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            children: [
              _Tile(accent: accent.reversed.toList(), height: 107),
              const SizedBox(height: 6),
              _Tile(accent: accent, height: 107),
            ],
          ),
        ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.accent, required this.height});

  final List<Color> accent;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = accent.length >= 2
        ? accent
        : [accent.first, ColorsCustom.navy];
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors.first, colors.last],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: CustomPaint(
        painter: _TesseraePainter(),
      ),
    );
  }
}

class _TesseraePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.18);
    const tile = 14.0;
    for (double y = 4; y < size.height; y += tile) {
      for (double x = 4; x < size.width; x += tile) {
        if ((x ~/ tile + y ~/ tile) % 3 == 0) continue;
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x, y, tile - 4, tile - 4),
            const Radius.circular(2),
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
