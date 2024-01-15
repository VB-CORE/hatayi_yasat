part of '../home_view.dart';

final class _HomeCategoryCards extends ConsumerWidget {
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
      height: context.sized.dynamicHeight(.12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const PagePadding.onlyRightVeryLow(),
            child: _CategoryCard(
              onTap: () async {
                final result =
                    await FilterRoute($extra: categories[index].documentId)
                        .push<FilterSelected?>(context);
                if (result == null) return;
                if (!context.mounted) return;
                FilterResultRoute(result).go(context);
              },
              name: categories[index].displayName,
            ),
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
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: WidgetSizes.spacingXxl9,
        child: Column(
          children: [
            Card(
              color: context.general.colorScheme.onPrimaryContainer,
              shape: const RoundedRectangleBorder(
                borderRadius: CustomRadius.extraLarge,
              ),
              child: Center(
                child: Padding(
                  padding: const PagePadding.vertical12Symmetric(),
                  child: GeneralBigTitle(
                    name[0],
                  ),
                ),
              ),
            ),
            Expanded(child: _CategoryCardTitle(name: name)),
          ],
        ),
      ),
    );
  }
}

final class _CategoryCardTitle extends StatelessWidget {
  const _CategoryCardTitle({
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return GeneralContentSubTitle(
      value: name,
      maxLine: TextFieldMaxLengths.minLine,
      fontWeight: FontWeight.bold,
    );
  }
}
