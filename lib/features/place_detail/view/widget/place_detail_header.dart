part of '../place_detail_view.dart';

final class PlaceDetailHeader extends StatelessWidget {
  const PlaceDetailHeader({
    required this.store,
    required this.scrollController,
    required this.patternHeight,
    super.key,
  });

  final StoreModel store;
  final ScrollController scrollController;
  final double patternHeight;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return SliverResizingHeader(
      minExtentPrototype: _CollapsedHeaderPrototype(
        topPadding: topPadding,
        child: PlaceSummaryCard(
          store: store,
          borderRadius: 0,
          showShadow: false,
        ),
      ),
      maxExtentPrototype: _ExpandedHeaderPrototype(
        patternHeight: patternHeight,
        overlapFactor: .25,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: PlaceSummaryCard(store: store),
        ),
      ),
      child: _HeaderContent(
        store: store,
        scrollController: scrollController,
        topPadding: topPadding,
        patternHeight: patternHeight,
      ),
    );
  }
}

final class _HeaderContent extends StatelessWidget {
  const _HeaderContent({
    required this.store,
    required this.scrollController,
    required this.topPadding,
    required this.patternHeight,
  });

  final StoreModel store;
  final ScrollController scrollController;
  final double topPadding;
  final double patternHeight;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        final collapseProgress = _calculateCollapseProgress();

        final horizontalMargin = ui.lerpDouble(
          AppSpacing.md,
          0,
          collapseProgress,
        )!;

        final borderRadius = ui.lerpDouble(AppRadius.lg, 0, collapseProgress)!;

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
                child: const CustomShimmer(child: MosaicBackground()),
              ),
              Positioned(
                top: topPadding,
                left: AppSpacing.sm,
                height: kToolbarHeight,
                child: Center(
                  child: IconButton(
                    onPressed: context.pop,
                    style: IconButton.styleFrom(
                      foregroundColor: AppColors.surface,
                      backgroundColor: AppColors.navy.withValues(alpha: .7),
                    ),
                    icon: const Icon(AppIcons.arrowBack),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
                  child: PlaceSummaryCard(
                    store: store,
                    borderRadius: borderRadius,
                    showShadow: collapseProgress < .95,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double _calculateCollapseProgress() {
    if (!scrollController.hasClients) return 0;
    final collapseDistance = patternHeight / 2;
    if (collapseDistance <= 0) return 1;
    return (scrollController.offset / collapseDistance).clamp(0.0, 1.0);
  }
}

final class _CollapsedHeaderPrototype extends StatelessWidget {
  const _CollapsedHeaderPrototype({
    required this.topPadding,
    required this.child,
  });

  final double topPadding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ExcludeSemantics(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: topPadding + kToolbarHeight),
            child,
          ],
        ),
      ),
    );
  }
}

final class _ExpandedHeaderPrototype extends StatelessWidget {
  const _ExpandedHeaderPrototype({
    required this.patternHeight,
    required this.overlapFactor,
    required this.child,
  });

  final double patternHeight;
  final double overlapFactor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ExcludeSemantics(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: patternHeight),
            Align(
              alignment: Alignment.topCenter,
              heightFactor: 1 - overlapFactor,
              child: FractionalTranslation(
                translation: Offset(0, -overlapFactor),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
