part of '../mosaic_collapsing_page.dart';

final class _MosaicCollapsingHeader extends StatelessWidget {
  const _MosaicCollapsingHeader({
    required this.scrollController,
    required this.header,
    required this.style,
    this.leading,
  });

  final ScrollController scrollController;
  final Widget header;
  final MosaicCollapsingHeaderStyle style;
  final Widget? leading;

  static const double _overlapFactor = .25;
  static const double _expandedMargin = AppSpacing.md;
  static const double _expandedRadius = AppRadius.lg;

  @override
  Widget build(BuildContext context) {
    final patternHeight = context.sized.dynamicHeight(style.heightFactor);
    final topPadding = MediaQuery.paddingOf(context).top;
    final collapsedTop = topPadding + (leading != null ? kToolbarHeight : 0);

    return SliverResizingHeader(
      minExtentPrototype: _measure(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: collapsedTop),
            _MosaicHeaderCard(
              borderRadius: 0,
              showShadow: false,
              padding: style.padding,
              child: header,
            ),
          ],
        ),
      ),
      maxExtentPrototype: _measure(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: patternHeight),
            Align(
              alignment: Alignment.topCenter,
              heightFactor: 1 - _overlapFactor,
              child: FractionalTranslation(
                translation: const Offset(0, -_overlapFactor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: _expandedMargin,
                  ),
                  child: _MosaicHeaderCard(
                    borderRadius: _expandedRadius,
                    showShadow: true,
                    padding: style.padding,
                    child: header,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      child: AnimatedBuilder(
        animation: scrollController,
        builder: (context, _) {
          final progress = _progress(patternHeight);
          final margin = ui.lerpDouble(_expandedMargin, 0, progress)!;
          final radius = ui.lerpDouble(_expandedRadius, 0, progress)!;

          return ColoredBox(
            color: AppColors.bg,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: patternHeight,
                  child: CustomShimmer(
                    child: MosaicBackground(gradient: style.gradient),
                  ),
                ),
                if (leading != null)
                  Positioned(
                    top: topPadding,
                    left: AppSpacing.sm,
                    height: kToolbarHeight,
                    child: Center(child: leading),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: margin),
                    child: _MosaicHeaderCard(
                      borderRadius: radius,
                      showShadow: progress < .95,
                      padding: style.padding,
                      child: header,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  double _progress(double patternHeight) {
    if (!scrollController.hasClients) return 0;
    final distance = patternHeight / 2;
    if (distance <= 0) return 1;
    return (scrollController.offset / distance).clamp(0.0, 1.0);
  }

  static Widget _measure(Widget child) {
    return IgnorePointer(child: ExcludeSemantics(child: child));
  }
}
