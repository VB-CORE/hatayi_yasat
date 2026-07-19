import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/shimmer/shimmer.dart';

@immutable
final class AdminListShimmer extends StatelessWidget {
  const AdminListShimmer({super.key});

  static const int _itemCount = 8;

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: ListView.separated(
        padding: const PagePadding.vertical12Symmetric(),
        itemCount: _itemCount,
        separatorBuilder: (context, index) => const EmptyBox.smallHeight(),
        itemBuilder: (context, index) => Container(
          height: WidgetSizes.spacingXxl9,
          decoration: BoxDecoration(
            color: context.general.colorScheme.surfaceContainerHighest,
            borderRadius: AppRadius.card,
          ),
        ),
      ),
    );
  }
}
