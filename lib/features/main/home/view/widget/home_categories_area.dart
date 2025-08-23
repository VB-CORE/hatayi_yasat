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

    return SizedBox(
      height: WidgetSizes.spacingXxl2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const PagePadding.onlyBottomLow(),
        itemBuilder: (BuildContext context, int index) {
          return _CategoryCard(
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
    ).ext.sliver;
  }
}

final class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.name,
    required this.onTap,
  });

  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.onlyRight(),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            color: context.general.colorScheme.onSecondaryFixed,
          ),
          backgroundColor: context.general.colorScheme.onSecondary,
          shape: const RoundedRectangleBorder(
            borderRadius: CustomRadius.extraLarge,
          ),
          padding: const PagePadding.horizontalNormalSymmetric(),
        ),
        child: Text(
          name,
          style: context.general.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.general.colorScheme.onSecondaryFixed,
          ),
        ),
      ),
    );
  }
}
