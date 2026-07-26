part of '../create_group_view.dart';

final class _CategorySection extends ConsumerWidget {
  const _CategorySection({
    required this.selectedCategory,
    required this.onSelected,
  });

  final GroupCategoryModel? selectedCategory;
  final ValueChanged<GroupCategoryModel> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(groupCategoriesViewModelProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldLabel(
          labelText: LocaleKeys.community_createGroup_categoryLabel.tr(),
        ),
        const EmptyBox.smallHeight(),
        switch (state) {
          GroupCategoriesState(isFetching: true) => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          GroupCategoriesState(isError: true) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralInfoBanner(
                message: LocaleKeys.community_createGroup_categoryLoadError
                    .tr(),
              ),
              TextButton(
                onPressed: ref
                    .read(groupCategoriesViewModelProvider.notifier)
                    .retry,
                child: Text(LocaleKeys.button_tryAgain.tr()),
              ),
            ],
          ),
          GroupCategoriesState(:final categories) => Wrap(
            spacing: WidgetSizes.spacingXs,
            runSpacing: WidgetSizes.spacingXs,
            children: categories
                .map(
                  (category) => CategoryChip(
                    label: category.name,
                    isSelected: category == selectedCategory,
                    onTap: () => onSelected(category),
                  ),
                )
                .toList(),
          ),
        },
      ],
    );
  }
}
