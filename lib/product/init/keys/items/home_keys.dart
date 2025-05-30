part of '../application_keys.dart';

final class _HomeKeys {
  _HomeKeys._();

  final Key homeView = const Key('home_view');
  final Key homeScrollableArea = const Key('home_scrollable_area');
  final Key categoryArea = const Key('category_area');
  Key categoryCard(int index) => Key('category_card_$index');
  Key placeCard(String id) => Key('place_card_$id');

  final Key placesGridArea = const Key('places_grid_area');
}
