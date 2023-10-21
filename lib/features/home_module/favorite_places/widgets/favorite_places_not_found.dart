part of '../view/favorite_places_view.dart';

class _FavoritePlacesNotFound extends ConsumerWidget {
  const _FavoritePlacesNotFound({
    required this.favoritePlaceProvider,
  });

  final StateNotifierProvider<FavoritePlacesProvider, FavoritePlacesState>
      favoritePlaceProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverFillRemaining(
      child: NotFoundLottie(
        title: LocaleKeys.notFound_favoritePlaces.tr(),
        onRefresh: () {
          ref.read(favoritePlaceProvider.notifier).getFavoritePlaces();
        },
      ),
    );
  }
}
