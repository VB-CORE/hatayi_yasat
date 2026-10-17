import 'dart:math' as math;
import 'dart:ui' show ImageFilter, lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/widget/builder/web_sidebar/web_sidebar.dart';

/// Lays the web sidebar out next to the framed card and morphs it out of the
/// card's left edge like a drop of liquid: it buds and stretches while still
/// attached, the neck thins and snaps, and it springs into place. Reversing
/// the animation draws it back into the card.
///
/// The liquid look is a "goo" filter (blur, then a hard alpha threshold) over
/// plain silhouettes of both surfaces, painted only while animating and only
/// around the card's left edge.
final class WebSidebarTransition extends StatelessWidget {
  const WebSidebarTransition({
    required this.animation,
    required this.card,
    required this.sidebar,
    required this.surfaceColor,
    required this.isSidebarRequested,
    this.cardWidth,
    super.key,
  });

  final Animation<double> animation;
  final Widget card;
  final Widget sidebar;
  final Color surfaceColor;

  /// Builds the sidebar (still invisible) one frame before the animation
  /// starts, so its first build does not land on the first animated frame.
  final bool isSidebarRequested;

  /// Fixed width of the framed card; null fills the available width.
  final double? cardWidth;

  static const double _gap = WidgetSizes.spacingXl;
  static const double _cornerRadius = WidgetSizes.spacingXl;

  /// How deep the root of the bud sits inside the card before it detaches.
  static const double _overlap = WidgetSizes.spacingXxl;
  static const double _budHeightFactor = .3;

  static const Interval _stretch = Interval(
    0,
    .5,
    curve: Curves.easeInOutCubic,
  );
  static const Interval _swell = Interval(0, .55, curve: Curves.easeInOutSine);
  static const Interval _detach = Interval(.3, 1, curve: _SpringCurve());
  static const Interval _slide = Interval(0, .7, curve: Curves.easeInOutCubic);
  static const Interval _reveal = Interval(.45, .8, curve: Curves.easeInOut);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => AnimatedBuilder(
        animation: animation,
        child: card,
        builder: (context, card) => _buildFrame(constraints, card!),
      ),
    );
  }

  /// The stack always holds the same three slots so the card, and the router
  /// inside it, is never reparented.
  Widget _buildFrame(BoxConstraints constraints, Widget card) {
    final progress = animation.value;
    final height = constraints.maxHeight;
    final width = cardWidth ?? constraints.maxWidth;
    final cardLeft = math.min(
      (WebSidebar.width + _gap) * _slide.transform(progress),
      math.max<double>(0, constraints.maxWidth - width),
    );

    final budRight =
        cardLeft + _overlap - (_overlap + _gap) * _detach.transform(progress);
    final budWidth = WebSidebar.width * _stretch.transform(progress);
    final budHeight =
        height * lerpDouble(_budHeightFactor, 1, _swell.transform(progress))!;
    final bud = Rect.fromLTWH(
      budRight - budWidth,
      (height - budHeight) / 2,
      budWidth,
      budHeight,
    );

    final gooLeft = math.min(bud.left, cardLeft) - _GooLayer.bleed;
    final gooRight = cardLeft + _overlap + _GooLayer.bleed;

    return SizedBox(
      width: cardLeft + width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: gooLeft,
            top: -_GooLayer.bleed,
            bottom: -_GooLayer.bleed,
            width: gooRight - gooLeft,
            child: animation.isAnimating
                ? _GooLayer(
                    color: surfaceColor,
                    origin: Offset(gooLeft, -_GooLayer.bleed),
                    shapes: [
                      _rounded(
                        Rect.fromLTRB(
                          cardLeft,
                          0,
                          gooRight + _GooLayer.bleed,
                          height,
                        ),
                      ),
                      _rounded(bud),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
          Positioned(
            left: budRight - WebSidebar.width,
            top: 0,
            bottom: 0,
            width: WebSidebar.width,
            child: isSidebarRequested || progress > 0
                ? Opacity(
                    opacity: _reveal.transform(progress),
                    child: RepaintBoundary(child: sidebar),
                  )
                : const SizedBox.shrink(),
          ),
          Positioned(
            left: cardLeft,
            top: 0,
            bottom: 0,
            width: width,
            child: RepaintBoundary(child: card),
          ),
        ],
      ),
    );
  }

  RRect _rounded(Rect rect) => RRect.fromRectAndRadius(
    rect,
    Radius.circular(math.min(_cornerRadius, rect.shortestSide / 2)),
  );
}

/// A spring that starts at rest, overshoots once and settles; unlike the
/// elastic and back curves it has no velocity jump on its first frame.
final class _SpringCurve extends Curve {
  const _SpringCurve();

  static const double _settleSeconds = .6;

  static final SpringSimulation _simulation = SpringSimulation(
    const SpringDescription(mass: 1, stiffness: 170, damping: 16),
    0,
    1,
    0,
  );

  @override
  double transformInternal(double t) => _simulation.x(t * _settleSeconds);
}

final class _GooLayer extends StatelessWidget {
  const _GooLayer({
    required this.shapes,
    required this.color,
    required this.origin,
  });

  final List<RRect> shapes;
  final Color color;

  /// Top-left of this layer in the coordinates of [shapes].
  final Offset origin;

  /// Room around the shapes for the blur and the bud's overshoot.
  static const double bleed = WidgetSizes.spacingXxl9;

  static const double _blurSigma = WidgetSizes.spacingS;

  /// Keeps colour, turns the blurred alpha ramp into a hard edge at ~50%.
  static const ColorFilter _threshold = ColorFilter.matrix([
    1, 0, 0, 0, 0, //
    0, 1, 0, 0, 0, //
    0, 0, 1, 0, 0, //
    0, 0, 0, 20, -2550,
  ]);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: ColorFiltered(
        colorFilter: _threshold,
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: _blurSigma,
            sigmaY: _blurSigma,
          ),
          child: CustomPaint(
            size: Size.infinite,
            painter: _GooPainter(shapes: shapes, color: color, origin: origin),
          ),
        ),
      ),
    );
  }
}

final class _GooPainter extends CustomPainter {
  const _GooPainter({
    required this.shapes,
    required this.color,
    required this.origin,
  });

  final List<RRect> shapes;
  final Color color;
  final Offset origin;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (final shape in shapes) {
      canvas.drawRRect(shape.shift(-origin), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GooPainter oldDelegate) => true;
}
