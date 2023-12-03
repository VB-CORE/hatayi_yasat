part of '../favorite_view.dart';

final class _FavoriteSearchField extends StatelessWidget {
  const _FavoriteSearchField({required this.onChanged});

  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const PagePadding.verticalVeryLowSymmetric() +
          const PagePadding.onlyTopLow(),
      sliver: CustomSearchField(
        hint: LocaleKeys.favorite_search.tr(),
        onChange: (value) {
          onChanged.call();
        },
      ).ext.sliver,
    );
  }
}
