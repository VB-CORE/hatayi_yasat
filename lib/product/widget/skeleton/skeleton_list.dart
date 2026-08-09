import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:shimmer/shimmer.dart';

final class SkeletonList extends StatelessWidget {
  const SkeletonList({this.itemCount = AppConstants.kFive, super.key});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.appColors.ink100,
      highlightColor: context.appColors.ink25,
      child: ListView.separated(
        padding:
            const PagePadding.horizontal16Symmetric() +
            const PagePadding.onlyTopMedium(),
        itemCount: itemCount,
        separatorBuilder: (context, index) => const EmptyBox.smallHeight(),
        itemBuilder: (context, index) => const _SkeletonCard(),
      ),
    );
  }
}

final class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.all(),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: context.appColors.ink100),
      ),
      child: Row(
        spacing: AppSpacing.sm,
        children: [
          const _Block(
            width: WidgetSizes.spacingXxl6,
            height: WidgetSizes.spacingXxl6,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.xs,
              children: [
                const _Block(width: double.infinity),
                _Block(width: context.sized.dynamicWidth(.2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _Block extends StatelessWidget {
  const _Block({required this.width, this.height = WidgetSizes.spacingS});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.appColors.ink200,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: SizedBox(width: width, height: height),
    );
  }
}
