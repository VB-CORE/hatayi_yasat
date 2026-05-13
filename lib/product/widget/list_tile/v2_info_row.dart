import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';

/// V2 mozaik info row — icon + label + value + optional trailing action.
///
/// Mirrors the V2 design `V2InfoRow`. Used across the place detail
/// "Hakkında" tab to lay out telephone, hours, address, and owner rows.
/// All chrome reads from the active `ColorScheme` so it adapts to dark
/// mode automatically.
class V2InfoRow extends StatelessWidget {
  const V2InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    super.key,
    this.actionLabel,
    this.onAction,
    this.multiline = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool multiline;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.onPrimaryContainer,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(
              icon,
              size: 18,
              color: colorScheme.onSecondaryFixed,
            ),
          ),
          const EmptyBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSecondaryFixed,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const EmptyBox(height: 2),
                Text(
                  value,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                    height: multiline ? 1.45 : 1.3,
                  ),
                ),
              ],
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            const EmptyBox.smallWidth(),
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                actionLabel!,
                style: V2Typography.label(
                  fontSize: 12,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
