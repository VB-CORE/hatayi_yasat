part of '../groups_view.dart';

final class _CategoryFilter extends ConsumerWidget {
  const _CategoryFilter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(
      groupCategoriesViewModelProvider.select((state) => state.categories),
    );
    if (categories.isEmpty) return const SizedBox.shrink();

    final selectedValue = ref.watch(
      groupsViewModelProvider.select((state) => state.selectedCategoryValue),
    );
    final notifier = ref.read(groupsViewModelProvider.notifier);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const PagePadding.horizontal16Symmetric(),
      child: Row(
        spacing: WidgetSizes.spacingXs,
        children: [
          CategoryChip(
            label: LocaleKeys.community_groups_allCategories.tr(),
            isSelected: selectedValue == null,
            onTap: () => notifier.selectCategory(null),
          ),
          ...categories.map(
            (category) => CategoryChip(
              label: category.name,
              isSelected: selectedValue == category.value,
              onTap: () => notifier.selectCategory(
                selectedValue == category.value ? null : category.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
