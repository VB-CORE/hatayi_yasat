part of 'favorite_places_view.dart';

class _FavoritePlacesBodyView extends ConsumerWidget {
  const _FavoritePlacesBodyView({required this.favoritePlaceProvider});
  final StateNotifierProvider<FavoritePlacesProvider, FavoritePlacesState>
      favoritePlaceProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(favoritePlaceProvider).favoritePlaces;
    final isLoading = ref.watch(favoritePlaceProvider).isLoading;

    if (isLoading) {
      return const _FavoritePlacesLoading();
    }

    if (items.isEmpty) {
      return _FavoritePlacesNotFound(
        favoritePlaceProvider: favoritePlaceProvider,
      );
    }

    return SliverPadding(
      padding: const PagePadding.horizontalLowSymmetric(),
      sliver: SliverList.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => _FavoriteItem(
          item: items[index],
          refreshCallback:
              ref.read(favoritePlaceProvider.notifier).getFavoritePlaces,
        ),
      ),
    );
  }
}

class _FavoriteItem extends ConsumerWidget {
  const _FavoriteItem({required this.item, required this.refreshCallback});
  final dynamic item;
  final VoidCallback refreshCallback;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = StoreModel.empty();
    return Padding(
      padding: const PagePadding.onlyTop(),
      child: PlaceCard(
        item: store,
        onTap: () {
          context.route
              .navigateToPage(HomeDetailView(model: store))
              .whenComplete(refreshCallback);
        },
      ),
    );
  }
}
