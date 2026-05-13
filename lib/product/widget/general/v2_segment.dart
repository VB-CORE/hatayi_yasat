import 'package:flutter/material.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';

class V2SegmentItem<T> {
  const V2SegmentItem({required this.value, required this.label, this.icon});

  final T value;
  final String label;
  final IconData? icon;
}

/// V2 segmented control — used by feed (Topluluk/Haberler/Etkinlikler) and
/// place detail (Hakkında/Bahsedilenler/Yorumlar).
class V2Segment<T> extends StatelessWidget {
  const V2Segment({
    required this.items,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final List<V2SegmentItem<T>> items;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: ColorsCustom.ink50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          for (final item in items)
            Expanded(
              child: _SegmentTile(
                item: item,
                active: item.value == value,
                onTap: () => onChanged(item.value),
              ),
            ),
        ],
      ),
    );
  }
}

class _SegmentTile<T> extends StatelessWidget {
  const _SegmentTile({
    required this.item,
    required this.active,
    required this.onTap,
  });

  final V2SegmentItem<T> item;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 6),
        decoration: BoxDecoration(
          color: active ? ColorsCustom.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: ColorsCustom.navy.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.icon != null) ...[
              Icon(
                item.icon,
                size: 14,
                color: active ? ColorsCustom.navy : ColorsCustom.ink500,
              ),
              const SizedBox(width: 5),
            ],
            Flexible(
              child: Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: active ? ColorsCustom.navy : ColorsCustom.ink500,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
