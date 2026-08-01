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
            selectedColor: context.appColors.coral50,
            backgroundColor: context.appColors.surface,
            onSelected: (_) => onSelected(category),
            label: Text(
              category.displayName,
              style: AppText.caption.copyWith(
                color: selected == category
                    ? context.appColors.coral600
                    : context.appColors.ink600,
              ),
            ),
          ),
      ],
    );
  }
}
