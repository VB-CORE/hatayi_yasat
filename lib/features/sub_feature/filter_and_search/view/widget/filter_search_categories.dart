part of '../filter_search_view.dart';

/// V2 category chip grid. Active chips switch to the coral accent (the
/// V2 design's "selected" treatment) and surface a check icon; inactive
/// chips read from the neutral surface roles and show a `+` add icon.
final class _FilterSearchCategories extends ConsumerWidget
    with AppProviderStateMixin {
  const _FilterSearchCategories();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = productState(ref).categoryItems;
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    final selected = ref.watch(filterWithSearchProvider).selectedCategories;

    if (categories.isEmpty) {
      return Padding(
        padding: const PagePadding.horizontalLowSymmetric(),
        child: Text(
          LocaleKeys.component_filter_noCategories.tr(),
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSecondaryFixed,
          ),
        ),
      );
    }

    final items = categories
        .map((e) => MultipleSelectItem(title: e.displayName, id: e.documentId))
        .toList();

    return Padding(
      padding: const PagePadding.horizontalLowSymmetric(),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final item in items)
            _CategoryChip(
              item: item,
              isActive: selected.any((it) => it.id == item.id),
              onTap: () {
                final next = List<MultipleSelectItem>.from(selected);
                final existingIndex = next.indexWhere((it) => it.id == item.id);
                if (existingIndex >= 0) {
                  next.removeAt(existingIndex);
                } else {
                  next.add(item);
                }
                ref
                    .read(filterWithSearchProvider.notifier)
                    .updateSelectedCategory(next);
              },
            ),
        ],
      ),
    );
  }
}

final class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final MultipleSelectItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;

    return Material(
      color: isActive
          ? colorScheme.error.withValues(alpha: 0.10)
          : colorScheme.secondary,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: isActive
                  ? colorScheme.error
                  : colorScheme.onPrimaryContainer,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isActive ? Icons.check_rounded : Icons.add_rounded,
                size: 14,
                color: isActive
                    ? colorScheme.error
                    : colorScheme.onSecondaryFixed,
              ),
              const EmptyBox(width: 4),
              Text(
                item.title.toUpperCase(),
                style: textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                  color: isActive ? colorScheme.error : colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
