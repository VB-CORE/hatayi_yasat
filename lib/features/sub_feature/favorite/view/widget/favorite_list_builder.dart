part of '../favorite_view.dart';

final class _FavoriteListBuilder extends ConsumerWidget {
  const _FavoriteListBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteProvider = ref.watch(favoriteViewModelProvider);
    final favoritePlaces = ref.watch(displayedFavoritePlacesProvider);

    if (favoritePlaces.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: favoriteProvider.isSearchActive
            ? _FavoriteSearchEmptyView(searchWord: favoriteProvider.searchWord)
            : const _FavoriteEmptyView(),
      );
    }

    if (favoriteProvider.isGridView) {
      return SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.sm,
          mainAxisExtent: MediaQuery.sizeOf(context).height * 0.21,
        ),
        itemCount: favoritePlaces.length,
        itemBuilder: (context, index) {
          return GeneralPlaceGridCard(
            key: ValueKey(favoritePlaces[index].documentId),
            storeModel: favoritePlaces[index],
            onCardTap: () async {
              await PlaceDetailRoute(
                $extra: favoritePlaces[index],
                id: favoritePlaces[index].documentId,
              ).push<void>(context);
            },
          );
        },
      );
    }

    return SliverList.builder(
      itemCount: favoritePlaces.length,
      itemBuilder: (context, index) {
        return _FavoriteAuthorWidget(
          key: ValueKey(favoritePlaces[index].documentId),
          model: favoritePlaces[index],
          onCardTapped: () async {
            await PlaceDetailRoute(
              $extra: favoritePlaces[index],
              id: favoritePlaces[index].documentId,
            ).push<void>(context);
          },
        );
      },
    );
  }
}

final class _FavoriteAuthorWidget extends StatelessWidget {
  const _FavoriteAuthorWidget({
    required this.model,
    required this.onCardTapped,
    super.key,
  });

  final StoreModel model;
  final VoidCallback onCardTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.vertical6Symmetric(),
      child: GeneralPlaceCard(
        onCardTap: onCardTapped,
        storeModel: model,
      ),
    );
  }
}
