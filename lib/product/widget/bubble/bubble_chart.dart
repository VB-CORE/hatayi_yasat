import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lifeclient/product/widget/bubble/bubble_data.dart';
import 'package:lifeclient/product/widget/bubble/bubble_item.dart';

final class BubbleChart extends StatefulWidget {
  const BubbleChart({
    required this.data,
    super.key,
  });

  final List<BubbleData> data;

  @override
  State<BubbleChart> createState() => _BubbleChartState();
}

final class _BubbleNode {
  _BubbleNode({
    required this.data,
    required this.radius,
    required this.position,
  });

  final BubbleData data;
  double radius;
  Offset position;
  Offset velocity = Offset.zero;
}

final class _BubbleChartState extends State<BubbleChart>
    with SingleTickerProviderStateMixin {
  static const _minRadius = 36.0;
  static const _maxRadius = 64.0;
  static const _centerForce = 0.05;
  static const _friction = 0.88;
  static const _maxSpeed = 0.45;
  static const _separationForce = 0.35;
  static const _bubbleGap = 14.0;
  static const _tapSlop = 8.0;
  static const _dragFollow = 0.03;
  static const _bounceDamping = 0.5;

  late final AnimationController _controller;
  final List<_BubbleNode> _bubbles = [];
  final Random _random = Random();

  Size? _size;
  int? _activeIndex;
  Offset? _dragTarget;
  Offset? _pointerStart;
  bool _hasDragged = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(_tick);
    unawaited(_controller.repeat());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(BubbleChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.data, widget.data) && _size != null) {
      _seedBubbles(_size!);
    }
  }

  void _seedBubbles(Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    _bubbles
      ..clear()
      ..addAll(
        widget.data.map((data) {
          final angle = _random.nextDouble() * pi * 2;
          final distance = 16 + _random.nextDouble() * 48;

          return _BubbleNode(
            data: data,
            radius:
                _minRadius + _random.nextDouble() * (_maxRadius - _minRadius),
            position: Offset(
              center.dx + cos(angle) * distance,
              center.dy + sin(angle) * distance,
            ),
          );
        }),
      );
  }

  void _tick() {
    if (_size == null || _bubbles.isEmpty || !mounted) return;

    final size = _size!;
    final center = Offset(size.width / 2, size.height / 2);
    final bounds = Rect.fromLTWH(
      0,
      context.general.mediaQuery.padding.top,
      size.width,
      size.height,
    );

    setState(() {
      _applyForces(center);
      _clampToBounds(bounds);
      _resolveCollisions();
    });
  }

  void _applyForces(Offset center) {
    for (var i = 0; i < _bubbles.length; i++) {
      final bubble = _bubbles[i];

      if (_activeIndex == i) {
        final target = _dragTarget;
        if (target != null) {
          final delta = target - bubble.position;
          bubble
            ..position += delta * _dragFollow
            ..velocity = delta * _dragFollow;
        }
        continue;
      }

      bubble
        ..velocity += (center - bubble.position) * _centerForce
        ..velocity *= _friction;

      final speed = bubble.velocity.distance;
      if (speed > _maxSpeed) {
        bubble.velocity *= _maxSpeed / speed;
      }

      bubble.position += bubble.velocity;
    }
  }

  void _clampToBounds(Rect bounds) {
    for (final bubble in _bubbles) {
      var x = bubble.position.dx;
      var y = bubble.position.dy;
      var vx = bubble.velocity.dx;
      var vy = bubble.velocity.dy;

      final minX = bounds.left + bubble.radius;
      final maxX = bounds.right - bubble.radius;
      final minY = bounds.top + bubble.radius;
      final maxY = bounds.bottom - bubble.radius;

      if (x < minX) {
        x = minX;
        vx = -vx * _bounceDamping;
      } else if (x > maxX) {
        x = maxX;
        vx = -vx * _bounceDamping;
      }

      if (y < minY) {
        y = minY;
        vy = -vy * _bounceDamping;
      } else if (y > maxY) {
        y = maxY;
        vy = -vy * _bounceDamping;
      }

      bubble
        ..position = Offset(x, y)
        ..velocity = Offset(vx, vy);
    }
  }

  void _resolveCollisions() {
    for (var i = 0; i < _bubbles.length; i++) {
      for (var j = i + 1; j < _bubbles.length; j++) {
        final a = _bubbles[i];
        final b = _bubbles[j];

        final delta = b.position - a.position;
        final distance = delta.distance;
        final minDistance = a.radius + b.radius + _bubbleGap;

        if (distance == 0 || distance >= minDistance) continue;

        final correction =
            (delta / distance) * (minDistance - distance) * _separationForce;

        a
          ..position -= correction * 0.5
          ..velocity *= 0.9;
        b
          ..position += correction * 0.5
          ..velocity *= 0.9;
      }
    }
  }

  int? _hitTest(Offset position) {
    for (var i = _bubbles.length - 1; i >= 0; i--) {
      if ((_bubbles[i].position - position).distance < _bubbles[i].radius) {
        return i;
      }
    }
    return null;
  }

  void _onPointerDown(Offset localPosition) {
    _activeIndex = _hitTest(localPosition);
    _pointerStart = localPosition;
    _dragTarget = localPosition;
    _hasDragged = false;
  }

  void _onPointerMove(Offset localPosition) {
    if (_activeIndex == null || _pointerStart == null) return;

    if (!_hasDragged &&
        (localPosition - _pointerStart!).distance > _tapSlop) {
      _hasDragged = true;
    }

    setState(() => _dragTarget = localPosition);
  }

  void _onPointerUp() {
    if (_activeIndex != null && !_hasDragged) {
      _bubbles[_activeIndex!].data.onTap?.call();
    }

    _activeIndex = null;
    _dragTarget = null;
    _pointerStart = null;
    _hasDragged = false;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        if (_size != size) {
          _size = size;
          if (_bubbles.isEmpty && widget.data.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              setState(() => _seedBubbles(size));
            });
          }
        }

        return Listener(
          behavior: HitTestBehavior.opaque,
          onPointerDown: (event) => _onPointerDown(event.localPosition),
          onPointerMove: (event) => _onPointerMove(event.localPosition),
          onPointerUp: (_) => _onPointerUp(),
          onPointerCancel: (_) => _onPointerUp(),
          child: Stack(
            children: [
              for (final bubble in _bubbles)
                Positioned(
                  left: bubble.position.dx - bubble.radius,
                  top: bubble.position.dy - bubble.radius,
                  child: IgnorePointer(
                    child: BubbleItem(
                      data: bubble.data,
                      radius: bubble.radius,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
