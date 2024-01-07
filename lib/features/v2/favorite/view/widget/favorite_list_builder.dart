part of '../favorite_view.dart';

final class _FavoriteListBuilder extends ConsumerWidget {
  const _FavoriteListBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteProvider = ref.watch(favoriteViewModelProvider);

    final favoritePlaces = favoriteProvider.filteredPlaces.isEmpty
        ? favoriteProvider.favoritePlaces
        : favoriteProvider.filteredPlaces;

    if (favoritePlaces.isEmpty) {
      return SliverFillRemaining(
        child:
            GeneralNotFoundLottie(title: LocaleKeys.message_emptyFavorite.tr()),
      );
    }
    return SliverList.builder(
      itemCount: favoritePlaces.length,
      itemBuilder: (context, index) {
        return _FavoriteAuthorWidget(
          model: favoritePlaces[index],
          onCardTapped: () {
            PlaceDetailRoute(
                    $extra: favoritePlaces[index],
                    id: favoritePlaces[index].documentId)
                .go(context);
          },
          onDeleteTapped: () {
            ref
                .read(favoriteViewModelProvider.notifier)
                .removeFavorite(favoritePlaces[index]);
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
    required this.onDeleteTapped,
  });

  final StoreModel model;
  final VoidCallback onCardTapped;
  final VoidCallback onDeleteTapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTapped.call,
      child: Padding(
        padding: const PagePadding.vertical6Symmetric(),
        child: AuthorListTileWidget(
          image: model.images.first,
          text: model.owner,
          description: model.name,
          onDeleteTapped: onDeleteTapped,
        ),
      ),
    );
  }
}
