part of '../developers_view.dart';

final class _SoftArcMosaic extends StatelessWidget {
  const _SoftArcMosaic();

  static const double _edgeRatio = 0.1;
  static const double _centerRatio = 0.5;

  @override
  Widget build(BuildContext context) {
    return const Stack(
      fit: StackFit.expand,
      children: [
        ClipPath(
          clipper: _SoftArcClipper(),
          child: MosaicBackground(showGradient: false),
        ),
        CustomPaint(painter: _SoftArcEdgePainter()),
      ],
    );
  }
}

final class _SoftArcClipper extends CustomClipper<Path> {
  const _SoftArcClipper();

  @override
  Path getClip(Size size) {
    final edgeY = size.height * _SoftArcMosaic._edgeRatio;
    return Path()
      ..moveTo(0, size.height)
      ..lineTo(0, edgeY)
      ..quadraticBezierTo(
        size.width / 2,
        size.height * _SoftArcMosaic._centerRatio,
        size.width,
        edgeY,
      )
      ..lineTo(size.width, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant _SoftArcClipper oldClipper) => false;
}

final class _SoftArcEdgePainter extends CustomPainter {
  const _SoftArcEdgePainter();

  Path _curve(Size size) {
    final edgeY = size.height * _SoftArcMosaic._edgeRatio;
    return Path()
      ..moveTo(0, edgeY)
      ..quadraticBezierTo(
        size.width / 2,
        size.height * _SoftArcMosaic._centerRatio,
        size.width,
        edgeY,
      );
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      _curve(size),
      Paint()
        ..color = AppColors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.height * 0.35
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, size.height * 0.12),
    );
  }

  @override
  bool shouldRepaint(covariant _SoftArcEdgePainter oldDelegate) => false;
}
