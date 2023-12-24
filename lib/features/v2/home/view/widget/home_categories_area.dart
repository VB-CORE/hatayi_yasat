part of '../home_view.dart';

final class _HomeCategoryCards extends ConsumerWidget {
  const _HomeCategoryCards();
  static const _maxCategoryItemLength = 6;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(homeViewModelProvider).categories
      ..take(_maxCategoryItemLength)
      ..sort((a, b) => a.displayName.length.compareTo(b.displayName.length));

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.red,
      onTap: () {},
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categories
              .map((e) => _CategoryCard(name: e.displayName))
              .toList(),
        ),
      ),
    ).ext.sliver;
  }
}

final class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sized.dynamicWidth(.2),
      child: Column(
        children: [
          Card(
            color: context.general.colorScheme.onPrimaryContainer,
            shape: const RoundedRectangleBorder(
              borderRadius: CustomRadius.extraLarge,
            ),
            child: Padding(
              padding: const PagePadding.horizontalSymmetric() +
                  const PagePadding.vertical12Symmetric(),
              child: GeneralBigTitle(
                name[0],
              ),
            ),
          ),
          _CategoryCardTitle(name: name),
        ],
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
