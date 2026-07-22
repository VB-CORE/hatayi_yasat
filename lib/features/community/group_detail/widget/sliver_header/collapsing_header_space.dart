part of '../group_detail_sliver_header.dart';

final class _CollapsingHeaderSpace extends StatelessWidget {
  const _CollapsingHeaderSpace({required this.model});

  final GroupModel model;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final topPadding = MediaQuery.paddingOf(context).top;
        final expandRatio = _expandRatioOf(constraints, topPadding);
        return Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: expandRatio,
              child: _ExpandedBackground(model: model),
            ),
            Positioned(
              top: topPadding,
              left: kZero,
              right: kZero,
              height: kToolbarHeight,
              child: _HeaderToolbar(
                model: model,
                titleOpacity: 1 - expandRatio,
              ),
            ),
          ],
        );
      },
    );
  }

  /// Header'ın ne kadar açık olduğu: 1 tamamen genişlemiş, 0 tamamen toplanmış.
  double _expandRatioOf(BoxConstraints constraints, double topPadding) {
    final collapsedHeight = topPadding + kToolbarHeight + kTextTabBarHeight;
    final maxExtent = WidgetSizes.spacingXxlL14 + topPadding;
    if (maxExtent <= collapsedHeight) return 0;
    return ((constraints.maxHeight - collapsedHeight) /
            (maxExtent - collapsedHeight))
        .clamp(0.0, 1.0);
  }
}
