import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';

final class MosaicBackground extends StatefulWidget {
  const MosaicBackground({
    this.gradient,
    this.showGradient = true,
    this.tileOpacity = 0.30,
    this.tileSize = 20,
    this.animate = false,
    this.animationDuration = const Duration(milliseconds: 500),
    super.key,
  });

  final Gradient? gradient;
  final bool showGradient;
  final double tileOpacity;
  final double tileSize;
  final bool animate;
  final Duration animationDuration;

  static const Gradient _defaultGradient = LinearGradient(
    begin: .topLeft,
    end: .bottomRight,
    colors: [AppColors.coral400, AppColors.gold300],
  );

  @override
  State<MosaicBackground> createState() => _MosaicBackgroundState();
}

final class _MosaicBackgroundState extends State<MosaicBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    if (widget.animate) {
      unawaited(_controller.forward());
    } else {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(covariant MosaicBackground oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.animate != widget.animate) {
      if (widget.animate) {
        _controller.reset();
        unawaited(_controller.forward());
      } else {
        _controller.value = 1;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _MosaicPatternPainter(
              gradient: widget.gradient ?? MosaicBackground._defaultGradient,
              showGradient: widget.showGradient,
              tileOpacity: widget.tileOpacity,
              tileSize: widget.tileSize,
              animationValue: _controller.value,
            ),
          );
        },
      ),
    );
  }
}

final class _MosaicPatternPainter extends CustomPainter {
  const _MosaicPatternPainter({
    required this.gradient,
    required this.showGradient,
    required this.tileOpacity,
    required this.tileSize,
    required this.animationValue,
  });

  final Gradient gradient;
  final bool showGradient;
  final double tileOpacity;
  final double tileSize;
  final double animationValue;

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

    if (showGradient) _paintGradient(canvas, bounds);

    _paintTiles(canvas, size);

    canvas.restore();
  }

  void _paintGradient(Canvas canvas, Rect bounds) {
    final paint = Paint()..shader = gradient.createShader(bounds);

    canvas.drawRect(bounds, paint);
  }

  void _paintTiles(Canvas canvas, Size size) {
    final paint = Paint();
    final tileStep = tileSize + _tileGap;
    const radius = Radius.circular(_tileRadius);

    final rowCount = (size.height / tileStep).ceil();
    final columnCount = (size.width / tileStep).ceil();

    final centerRow = (rowCount - 1) / 2;
    final centerColumn = (columnCount - 1) / 2;

    final maxDistance = sqrt(pow(centerRow, 2) + pow(centerColumn, 2));

    for (var row = 0; row < rowCount; row++) {
      for (var column = 0; column < columnCount; column++) {
        final distance = sqrt(
          pow(row - centerRow, 2) + pow(column - centerColumn, 2),
        );

        final delay = distance / maxDistance;

        final progress = Curves.easeOut.transform(
          ((animationValue - delay) / (1 - delay)).clamp(0.0, 1.0),
        );

        paint.color = _resolveColor(
          row: row,
          column: column,
        ).withValues(alpha: tileOpacity * progress);

        final rect = Rect.fromLTWH(
          column * tileStep,
          row * tileStep,
          tileSize,
          tileSize,
        );

        canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), paint);
      }
    }
  }

  Color _resolveColor({required int row, required int column}) {
    final colorIndex = (column - row) % _colors.length;
    return _colors[colorIndex];
  }

  @override
  bool shouldRepaint(covariant _MosaicPatternPainter oldDelegate) {
    return oldDelegate.gradient != gradient ||
        oldDelegate.showGradient != showGradient ||
        oldDelegate.tileOpacity != tileOpacity ||
        oldDelegate.tileSize != tileSize ||
        oldDelegate.animationValue != animationValue;
  }
}
