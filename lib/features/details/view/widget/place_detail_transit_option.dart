part of '../place_detail_view.dart';

/// Square transit chip — icon + display-typography time + small label.
/// Used inside the Hakkında tab's location & transit grid.
final class _TransitOption extends StatelessWidget {
  const _TransitOption({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: colorScheme.onPrimaryFixed,
        borderRadius: CustomRadius.medium,
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: colorScheme.primary),
          const EmptyBox(height: 4),
          Text(
            value,
            style: V2Typography.display(
              fontSize: 14,
              color: colorScheme.onSurface,
            ),
          ),
          const EmptyBox(height: 2),
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onSecondaryFixed,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
