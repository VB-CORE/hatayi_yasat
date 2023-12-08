part of '../home_view.dart';

final class _HomeCategoryCards extends StatelessWidget {
  const _HomeCategoryCards();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CategoryCard(
          name: 'Adana',
          onTap: () {},
        ),
        _CategoryCard(
          name: 'Hatay',
          onTap: () {},
        ),
        _CategoryCard(
          name: 'Maraş',
          onTap: () {},
        ),
        _CategoryCard(
          name: 'Gaziantep',
          onTap: () {},
        ),
      ],
    );
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
    return Column(
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
              name.substring(0, 1),
            ),
          ),
        ),
        _CategoryCardTitle(name: name),
      ],
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
    return Padding(
      padding: const PagePadding.onlyTopLow(),
      child: GeneralContentSubTitle(
        value: name,
        maxLine: 2,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
