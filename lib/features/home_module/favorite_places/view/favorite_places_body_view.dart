part of 'favorite_places_view.dart';

class _FavoritePlacesBodyView extends ConsumerWidget
    with FavoritePlaceConverterMixin {
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
        itemBuilder: (context, index) => _buildItem(context, items[index]),
      ),
    );
  }

  Widget _buildItem(BuildContext context, FavoritePlaceModel item) {
    final store = convertToStore(item);
    return Padding(
      padding: const PagePadding.onlyTop(),
      child: PlaceCard(
        item: store,
        onTap: () {
          context.route.navigateToPage(HomeDetailView(model: store));
        },
      ),
    );
  }
}
