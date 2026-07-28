part of '../merchant_store_edit_sub_view.dart';

final class _MerchantCategoryPicker extends StatelessWidget {
  const _MerchantCategoryPicker({
    required this.selected,
    required this.categories,
    required this.onSelected,
  });

  final CategoryModel? selected;
  final List<CategoryModel> categories;
  final ValueChanged<CategoryModel> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: [
        for (final category in categories)
          ChoiceChip(
            selected: selected == category,
            showCheckmark: false,
            selectedColor: AppColors.coral50,
            backgroundColor: AppColors.surface,
            onSelected: (_) => onSelected(category),
            label: Text(
              category.displayName,
              style: AppText.caption.copyWith(
                color: selected == category
                    ? AppColors.coral600
                    : AppColors.ink600,
              ),
            ),
          ),
      ],
    );
  }
}
