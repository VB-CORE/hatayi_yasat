import 'package:flutter/material.dart';

/// Subtle mozaik backdrop — paints a faint tile grid over a surface.
///
/// Mirrors the V2 design `MosaicGrid2`. Stack as an overlay inside a
/// container with a coloured ground (e.g. navy hero, coral CTA) to add
/// the mosaic identity texture without committing to a heavy pattern.
class MosaicGrid extends StatelessWidget {
  const MosaicGrid({
    super.key,
    this.tileSize = 14,
    this.opacity = 0.16,
    this.lineColor = Colors.white,
  });

  final double tileSize;
  final double opacity;
  final Color lineColor;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: opacity,
        child: CustomPaint(
          size: Size.infinite,
          painter: _MosaicGridPainter(
            tileSize: tileSize,
            lineColor: lineColor,
          ),
        ),
      ),
    );
  }
}

class _MosaicGridPainter extends CustomPainter {
  _MosaicGridPainter({required this.tileSize, required this.lineColor});

  final double tileSize;
  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor.withValues(alpha: 0.33)
      ..strokeWidth = 1;
    for (double x = 0; x <= size.width; x += tileSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += tileSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _MosaicGridPainter old) =>
      old.tileSize != tileSize || old.lineColor != lineColor;
}
