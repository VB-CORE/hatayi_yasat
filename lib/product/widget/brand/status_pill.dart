import 'package:flutter/material.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';

/// Size variant for [StatusPill]. Mirrors the `sm/md/lg` sizing used in the
/// V2 design.
enum StatusPillSize { sm, md, lg }

/// V2 mozaik status pill (Açık / Kapalı).
///
/// Olive when [isOpen], coral when closed. Optionally appends [hours]
/// after the label for surfaces that need the time on a single line
/// (e.g. mekan kartı footer).
class StatusPill extends StatelessWidget {
  const StatusPill({
    required this.isOpen,
    super.key,
    this.hours,
    this.size = StatusPillSize.md,
  });

  final bool isOpen;
  final String? hours;
  final StatusPillSize size;

  @override
  Widget build(BuildContext context) {
    final dim = _dimensions;
    final accent = isOpen ? ColorsCustom.olive : ColorsCustom.coral;
    final accentBg = isOpen ? ColorsCustom.olive50 : ColorsCustom.coral50;
    final accentInk = isOpen ? ColorsCustom.olive600 : ColorsCustom.coral600;

    return Container(
      padding: dim.padding,
      decoration: BoxDecoration(
        color: accentBg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: dim.dot,
            height: dim.dot,
            decoration: BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: accentBg, spreadRadius: 3),
              ],
            ),
          ),
          SizedBox(width: dim.gap),
          Text(
            hours == null
                ? (isOpen ? 'AÇIK' : 'KAPALI')
                : '${isOpen ? 'AÇIK' : 'KAPALI'} · $hours',
            style: TextStyle(
              fontSize: dim.fontSize,
              fontWeight: FontWeight.w700,
              letterSpacing: dim.fontSize * 0.04,
              color: accentInk,
            ),
          ),
        ],
      ),
    );
  }

  _PillDim get _dimensions {
    switch (size) {
      case StatusPillSize.sm:
        return const _PillDim(
          fontSize: 10,
          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          dot: 5,
          gap: 6,
        );
      case StatusPillSize.md:
        return const _PillDim(
          fontSize: 11,
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          dot: 6,
          gap: 6,
        );
      case StatusPillSize.lg:
        return const _PillDim(
          fontSize: 12,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          dot: 7,
          gap: 6,
        );
    }
  }
}

class _PillDim {
  const _PillDim({
    required this.fontSize,
    required this.padding,
    required this.dot,
    required this.gap,
  });

  final double fontSize;
  final EdgeInsets padding;
  final double dot;
  final double gap;
}
