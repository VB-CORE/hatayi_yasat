part of '../login_view.dart';

final class _LoginBackground extends StatelessWidget {
  const _LoginBackground();

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Positioned.fill(
      child: ColoredBox(
        color: backgroundColor,
        child: ShaderMask(
          blendMode: BlendMode.dstIn,
          shaderCallback: (bounds) => const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.transparent,
              Colors.transparent,
            ],
            stops: [0, .45, 1],
          ).createShader(bounds),
          child: MosaicBackground(
            tileOpacity: .40,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                context.appColors.navy,
                context.appColors.navy400,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
