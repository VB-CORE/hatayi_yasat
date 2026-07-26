import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';

final class MosaicBackground extends StatelessWidget {
  const MosaicBackground({
    this.gradient,
    this.showGradient = true,
    this.tileOpacity = 0.30,
    super.key,
  });

  final Gradient? gradient;
  final bool showGradient;
  final double tileOpacity;

  static const Gradient _defaultGradient = LinearGradient(
    begin: .topLeft,
    end: .bottomRight,
    colors: [AppColors.coral400, AppColors.gold300],
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _MosaicPatternPainter(
          gradient: gradient ?? _defaultGradient,
          showGradient: showGradient,
          tileOpacity: tileOpacity,
        ),
      ),
    );
  }
}

final class _MosaicPatternPainter extends CustomPainter {
  const _MosaicPatternPainter({
    required this.gradient,
    required this.showGradient,
    required this.tileOpacity,
  });

  final Gradient gradient;
  final bool showGradient;
  final double tileOpacity;

  static const double _tileSize = 20;
  static const double _tileGap = 7;
  static const double _tileRadius = 4;

  static const List<Color> _colors = [
    AppColors.gold300,
    AppColors.coral400,
    AppColors.ink400,
    AppColors.navy400,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;

    canvas
      ..save()
      ..clipRect(bounds);

    if (showGradient) {
      _paintGradient(canvas, bounds);
    }
    _paintTiles(canvas, size);

    canvas.restore();
  }

  void _paintGradient(Canvas canvas, Rect bounds) {
    final paint = Paint()..shader = gradient.createShader(bounds);

    canvas.drawRect(bounds, paint);
  }

  void _paintTiles(Canvas canvas, Size size) {
    final paint = Paint();
    const tileStep = _tileSize + _tileGap;
    const radius = Radius.circular(_tileRadius);

    final rowCount = (size.height / tileStep).ceil();
    final columnCount = (size.width / tileStep).ceil();

    for (var row = 0; row < rowCount; row++) {
      for (var column = 0; column < columnCount; column++) {
        paint.color = _resolveColor(
          row: row,
          column: column,
        ).withValues(alpha: tileOpacity);

        final rect = Rect.fromLTWH(
          column * tileStep,
          row * tileStep,
          _tileSize,
          _tileSize,
        );

        canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), paint);
      }
    }
  }

  Color _resolveColor({
    required int row,
    required int column,
  }) {
    final colorIndex = (column - row) % _colors.length;
    return _colors[colorIndex];
  }

  @override
  bool shouldRepaint(covariant _MosaicPatternPainter oldDelegate) {
    return oldDelegate.gradient != gradient ||
        oldDelegate.showGradient != showGradient ||
        oldDelegate.tileOpacity != tileOpacity;
  }
}
