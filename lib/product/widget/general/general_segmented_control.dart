import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/product/widget/bounceable/bounceable.dart';
import 'package:lifeclient/product/widget/general/title/general_content_small_title.dart';

@immutable
final class GeneralSegmentedControl<T> extends StatelessWidget {
  const GeneralSegmentedControl({
    required this.value,
    required this.options,
    required this.labelBuilder,
    required this.onChanged,
    super.key,
  });

  final T value;
  final List<T> options;
  final String Function(T option) labelBuilder;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.allVeryLow(),
      decoration: BoxDecoration(
        color: context.general.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final option in options)
            _SegmentButton(
              selected: option == value,
              label: labelBuilder(option),
              onTap: () => onChanged(option),
            ),
        ],
      ),
    );
  }
}

final class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.selected,
    required this.label,
    required this.onTap,
  });

  final bool selected;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomBounceable(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Durations.short4,
        padding:
            const PagePadding.horizontalLowSymmetric() +
            const PagePadding.vertical8Symmetric(),
        decoration: BoxDecoration(
          color: selected
              ? context.general.colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: GeneralContentSmallTitle(
          value: label,
          fontWeight: FontWeight.w700,
          color: selected
              ? context.general.colorScheme.onPrimary
              : context.general.colorScheme.onSurface,
        ),
      ),
    );
  }
}
