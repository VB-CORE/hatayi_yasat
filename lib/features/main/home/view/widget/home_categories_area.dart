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

    return SingleChildScrollView(
      key: const Key('homeCategoriesList'),
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: AppSpacing.xs,
        children: [
          for (final category in categories)
            _CategoryCard(
              key: Key('categoryCard_${category.documentId}'),
              onTap: () async {
                await pushToFilter(
                  context: context,
                  category: category.documentId,
                );
              },
              name: category.displayName,
            ),
        ],
      ),
    ).ext.sliver;
  }
}

final class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.name, required this.onTap, super.key});

  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        side: const BorderSide(color: AppColors.surface),
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: .circular(AppRadius.md)),
      ),
      child: Text(
        name,
        style: context.general.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: context.general.colorScheme.onSecondaryFixed,
        ),
      ),
    );
  }
}
