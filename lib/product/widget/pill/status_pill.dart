import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';

/// Open/closed status pill driven by [StoreModelHelper.isStoreOpen].
///
/// Renders a colored dot + label (olive when open, coral when closed) and,
/// when [showHours] is true and the store has hours, the `open – close` range.
/// Renders nothing when the store has no parseable working hours.
final class StatusPill extends StatelessWidget {
  const StatusPill({required this.store, this.showHours = true, super.key});

  final StoreModel store;
  final bool showHours;

  @override
  Widget build(BuildContext context) {
    final isOpen = StoreModelHelper(model: store).isStoreOpen;
    if (isOpen == null) return const SizedBox.shrink();

    final color = isOpen ? AppColors.olive600 : AppColors.coral600;
    final background = isOpen ? AppColors.olive50 : AppColors.coral50;
    final label = isOpen
        ? LocaleKeys.placeDetailView_nowOpen.tr()
        : LocaleKeys.placeDetailView_nowClose.tr();
    final hours = _hours;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppSpacing.xs,
            height: AppSpacing.xs,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSpacing.xxs),
          Flexible(
            child: Text(
              hours == null ? label : '$label · $hours',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.micro.copyWith(
                color: color,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? get _hours {
    if (!showHours) return null;
    final open = store.openTime;
    final close = store.closeTime;
    if (open == null || open.isEmpty || close == null || close.isEmpty) {
      return null;
    }
    return '$open – $close';
  }
}
