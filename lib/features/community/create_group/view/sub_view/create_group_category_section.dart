part of '../create_group_view.dart';

final class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  final List<GroupCategoryModel> categories;
  final GroupCategoryModel? selectedCategory;
  final ValueChanged<GroupCategoryModel> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RequiredLabel(LocaleKeys.community_createGroup_categoryLabel.tr()),
        const EmptyBox.smallHeight(),
        Wrap(
          spacing: WidgetSizes.spacingXs,
          runSpacing: WidgetSizes.spacingXs,
          children: categories.map((category) {
            return CategoryChip(
              label: category.name,
              isSelected: category == selectedCategory,
              onTap: () => onSelected(category),
            );
          }).toList(),
        ),
      ],
    );
  }
}
