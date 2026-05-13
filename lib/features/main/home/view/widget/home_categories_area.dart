part of '../home_view.dart';

/// It will help to navigate filter screen and get result from filter screen
mixin _FilterMixin {
  Future<void> pushToFilter({
    required BuildContext context,
    String? category,
  }) async {
    FilterRoute($extra: category).go(context);
  }
}

/// Horizontal category strip — V2 mozaik chip style. Tap a chip to jump
/// straight into the filter result for that category.
final class _HomeCategoryCards extends ConsumerWidget with _FilterMixin {
  const _HomeCategoryCards();
  static const _maxCategoryItemLength = 6;
  static const _otherCategoryValue = 1000;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(homeViewModelProvider).categories
      ..take(_maxCategoryItemLength)
      ..sort((a, b) => a.displayName.length.compareTo(b.displayName.length))
      /// remove other category
      ..removeWhere((element) => element.value == _otherCategoryValue);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const PagePadding.horizontalLowSymmetric(),
          child: Eyebrow(
            LocaleKeys.home_categoriesEyebrow.tr(),
            color: context.general.colorScheme.onSecondaryContainer,
          ),
        ),
        const EmptyBox.smallHeight(),
        SizedBox(
          height: WidgetSizes.spacingXxl2,
          child: ListView.builder(
            key: const Key('homeCategoriesList'),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemBuilder: (BuildContext context, int index) {
              return _CategoryCard(
                key: Key('categoryCard_${categories[index].documentId}'),
                onTap: () async {
                  await pushToFilter(
                    context: context,
                    category: categories[index].documentId,
                  );
                },
                name: categories[index].displayName,
              );
            },
          ),
        ),
      ],
    ).ext.sliver;
  }
}

final class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.name, required this.onTap, super.key});

  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Material(
        color: colorScheme.onPrimaryFixed,
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: colorScheme.onPrimaryContainer),
            ),
            alignment: Alignment.center,
            child: Text(
              name,
              style: textTheme.labelMedium?.copyWith(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
