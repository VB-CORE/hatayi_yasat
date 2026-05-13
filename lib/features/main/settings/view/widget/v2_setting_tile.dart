part of '../settings_view.dart';

/// V2 row used everywhere in the new settings page. Coral-tinted (or
/// destructive) icon container, label, optional trailing value, and a
/// chevron. Rows are rendered inside a bordered group card and separated
/// by a hairline divider; pass `isLast: true` on the bottom row so the
/// divider is suppressed.
final class _V2SettingTile extends StatelessWidget {
  const _V2SettingTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.value,
    this.destructive = false,
    this.isLast = false,
    super.key,
  });

  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback onTap;
  final bool destructive;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    final accent = destructive ? colorScheme.error : colorScheme.primary;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isLast
                  ? Colors.transparent
                  : colorScheme.onPrimaryContainer.withValues(alpha: 0.5),
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.10),
                borderRadius: CustomRadius.medium,
              ),
              child: Icon(icon, size: 20, color: accent),
            ),
            const EmptyBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: textTheme.titleSmall?.copyWith(
                  fontSize: 14,
                  fontWeight: destructive ? FontWeight.w700 : FontWeight.w600,
                  color: destructive
                      ? colorScheme.error
                      : colorScheme.onSurface,
                ),
              ),
            ),
            if (value != null) ...[
              Text(
                value!,
                style: textTheme.labelMedium?.copyWith(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSecondaryFixed,
                ),
              ),
              const EmptyBox(width: 6),
            ],
            Icon(
              Icons.chevron_right_rounded,
              color: colorScheme.onSecondaryFixed,
            ),
          ],
        ),
      ),
    );
  }
}

/// Wraps a list of `_V2SettingTile`s in a single bordered card so they
/// read as one grouped block (matches the GENEL / HESAP / DESTEK groups
/// in the V2 design).
final class _V2SettingsGroup extends StatelessWidget {
  const _V2SettingsGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Padding(
      padding: const PagePadding.horizontalSymmetric(),
      child: Material(
        color: colorScheme.secondary,
        borderRadius: CustomRadius.large,
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: CustomRadius.large,
            border: Border.all(color: colorScheme.onPrimaryContainer),
          ),
          child: Column(children: children),
        ),
      ),
    );
  }
}
