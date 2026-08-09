import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';

final class DetailSheet extends StatelessWidget {
  const DetailSheet({required this.children, super.key});

  final List<Widget> children;

  static const double _maxHeightFactor = 0.78;

  static Future<void> show({
    required BuildContext context,
    required List<Widget> children,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.appColors.surface,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.sheet),
      builder: (context) => DetailSheet(children: children),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: context.sized.height * _maxHeightFactor,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _GrabHandle(),
            Flexible(
              child: SingleChildScrollView(
                padding: const PagePadding.generalAllNormal(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpacing.sm,
                  children: children,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _GrabHandle extends StatelessWidget {
  const _GrabHandle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.vertical8Symmetric(),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.appColors.ink100,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: const SizedBox(
          width: WidgetSizes.spacingXxl4,
          height: WidgetSizes.spacingXxs,
        ),
      ),
    );
  }
}
