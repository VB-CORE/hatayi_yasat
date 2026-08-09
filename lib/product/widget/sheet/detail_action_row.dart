import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/link_actions.dart';
import 'package:lifeclient/product/widget/general/index.dart';

final class DetailActionRow extends StatelessWidget {
  const DetailActionRow({
    required this.labelKey,
    required this.value,
    required this.icon,
    required this.primaryIcon,
    required this.primaryTooltipKey,
    required this.onPrimary,
    required this.accent,
    super.key,
  });

  final String labelKey;
  final String value;
  final IconData icon;
  final IconData primaryIcon;
  final String primaryTooltipKey;
  final VoidCallback onPrimary;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: context.appColors.ink100),
      ),
      child: Padding(
        padding: const PagePadding.generalAllLow(),
        child: Row(
          spacing: AppSpacing.sm,
          children: [
            Icon(icon, color: context.appColors.ink400),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GeneralContentSmallTitle(value: labelKey.tr().toUpperCase()),
                  GeneralBodyTitle(
                    value,
                    textAlign: TextAlign.start,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ],
              ),
            ),
            _ActionButton(
              icon: AppIcons.copy,
              tooltipKey: LocaleKeys.general_action_copy,
              onTap: () => LinkActions.copy(context, value),
              foreground: context.appColors.ink600,
              background: context.appColors.surface,
              borderColor: context.appColors.ink100,
            ),
            _ActionButton(
              icon: primaryIcon,
              tooltipKey: primaryTooltipKey,
              onTap: onPrimary,
              foreground: context.appColors.surface,
              background: accent,
              borderColor: accent,
            ),
          ],
        ),
      ),
    );
  }
}

final class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.tooltipKey,
    required this.onTap,
    required this.foreground,
    required this.background,
    required this.borderColor,
  });

  final IconData icon;
  final String tooltipKey;
  final VoidCallback onTap;
  final Color foreground;
  final Color background;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltipKey.tr(),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: borderColor),
          ),
          child: SizedBox.square(
            dimension: WidgetSizes.spacingXxl5,
            child: Center(
              child: Icon(icon, color: foreground, size: AppIconSizes.medium),
            ),
          ),
        ),
      ),
    );
  }
}
