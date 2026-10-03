part of '../web_sidebar.dart';

final class _WebSidebarItem extends StatelessWidget {
  const _WebSidebarItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isSelected = false,
    this.badgeCount = 0,
  });

  static const int _maxBadgeCount = 99;

  final Widget icon;
  final String title;
  final VoidCallback onTap;
  final bool isSelected;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final foreground = isSelected
        ? colorScheme.primary
        : context.appColors.ink600;

    return Material(
      color: colorScheme.primary.withValues(alpha: isSelected ? .08 : 0),
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        hoverColor: colorScheme.primary.withValues(alpha: .04),
        child: Padding(
          padding: const PagePadding.horizontalLowVerticalVeryLowSymmetric() +
              const PagePadding.verticalVeryLowSymmetric() / 2,
          child: IconTheme.merge(
            data: IconThemeData(color: foreground, size: WidgetSizes.spacingL),
            child: Row(
              spacing: AppSpacing.sm,
              children: [
                SizedBox.square(
                  dimension: WidgetSizes.spacingXl,
                  child: Center(child: icon),
                ),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.body.copyWith(
                      color: foreground,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                ),
                if (badgeCount > 0) _Badge(count: badgeCount),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _Badge extends StatelessWidget {
  const _Badge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.tertiary,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Padding(
        padding: const PagePadding.horizontalVeryLowSymmetric(),
        child: Text(
          count > _WebSidebarItem._maxBadgeCount
              ? '${_WebSidebarItem._maxBadgeCount}+'
              : '$count',
          style: AppText.micro.copyWith(color: colorScheme.onTertiary),
        ),
      ),
    );
  }
}
