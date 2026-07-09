import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/sorting_types.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';

/// Single-select "Sırala" bottom sheet. Returns the chosen [SortingTypes] or
/// null when dismissed.
final class PlaceSortSheet extends StatelessWidget {
  const PlaceSortSheet({required this.current, super.key});

  final SortingTypes current;

  static Future<SortingTypes?> show(
    BuildContext context, {
    required SortingTypes current,
  }) {
    return showModalBottomSheet<SortingTypes>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.sheet),
      builder: (_) => PlaceSortSheet(current: current),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _SheetHandle(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.xs,
              AppSpacing.sm,
              AppSpacing.xs,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.sorting_title.tr(),
                  style: AppText.title.copyWith(fontSize: 18),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(AppIcons.close, color: AppColors.ink500),
                ),
              ],
            ),
          ),
          for (final type in SortingTypes.values)
            _SortRow(
              type: type,
              isActive: type == current,
              onTap: () => Navigator.of(context).pop(type),
            ),
          const SizedBox(height: AppSpacing.xs),
        ],
      ),
    );
  }
}

final class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 4,
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.ink200,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
    );
  }
}

final class _SortRow extends StatelessWidget {
  const _SortRow({
    required this.type,
    required this.isActive,
    required this.onTap,
  });

  final SortingTypes type;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.ink50)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Icon(
                isActive ? AppIcons.check : type.icon,
                color: isActive ? AppColors.coral : AppColors.ink500,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  type.detail.tr(),
                  style: AppText.body.copyWith(
                    color: isActive ? AppColors.navy : AppColors.ink700,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              const Icon(
                AppIcons.rightSelect,
                color: AppColors.ink300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
