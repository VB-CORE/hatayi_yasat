part of '../favorite_view.dart';

final class _FavoriteListBuilder extends ConsumerWidget {
  const _FavoriteListBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteProvider = ref.watch(favoriteViewModelProvider);
    final isSearchActive = favoriteProvider.searchWord.isNotEmpty;

    final favoritePlaces = isSearchActive
        ? favoriteProvider.filteredPlaces
        : favoriteProvider.favoritePlaces;

    if (favoritePlaces.isEmpty) {
      return SliverFillRemaining(
        child: SingleChildScrollView(
          child: GeneralNotFoundWidget(
            title: isSearchActive
                ? LocaleKeys.favorite_noBusinessFound.tr()
                : LocaleKeys.message_emptyFavorite.tr(),
          ),
        ),
      );
    }
    final colorScheme = context.general.colorScheme;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList.separated(
        itemCount: favoritePlaces.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final store = favoritePlaces[index];
          return Dismissible(
            key: ValueKey('favorite_${store.documentId}'),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: colorScheme.error.withValues(alpha: 0.1),
                borderRadius: CustomRadius.large,
              ),
              child: Icon(
                Icons.delete_outline_rounded,
                color: colorScheme.error,
              ),
            ),
            onDismissed: (_) => ref
                .read(favoriteViewModelProvider.notifier)
                .removeFavorite(store),
            child: V2PlaceCard(
              place: V2Place.fromStore(store),
              saved: true,
              onTap: () {
                PlaceDetailRoute(
                  $extra: store,
                  id: store.documentId,
                ).push<void>(context);
              },
              onSavedToggle: () => ref
                  .read(favoriteViewModelProvider.notifier)
                  .removeFavorite(store),
            ),
          );
        },
      ),
    );
  }
}
