part of '../favorite_view.dart';

final class _FavoriteSearchField extends ConsumerWidget {
  const _FavoriteSearchField({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(favoriteViewModelProvider).favoritePlaces;
    if (items.isEmpty) {
      return const SliverToBoxAdapter();
    }
    return SliverPadding(
      padding: const PagePadding.verticalVeryLowSymmetric() +
          const PagePadding.onlyTopLow(),
      sliver: CustomSearchField(
        hint: LocaleKeys.favorite_search.tr(),
        onChange: onChanged,
      ).ext.sliver,
    );
  }
}
