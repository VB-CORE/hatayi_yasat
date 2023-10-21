part of '../view/favorite_places_view.dart';

class _FavoritePlacesLoading extends StatelessWidget {
  const _FavoritePlacesLoading();

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: Padding(
        padding: PagePadding.onlyTop(),
        child: PlaceShimmerList(),
      ),
    );
  }
}
