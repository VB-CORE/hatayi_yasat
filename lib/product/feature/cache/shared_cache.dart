import 'dart:convert';

import 'package:kartal/kartal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vbaseproject/features/home_module/home_detail/models/favorite_place_model.dart';

enum SharedKeys { firstAppOpen, favoritePlaces }

final class SharedCache {
  SharedCache._internal();
  static final SharedCache instance = SharedCache._internal();

  late SharedPreferences _preferences;
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> clear() async {
    await _preferences.clear();
  }

  Future<void> setFirstAppOpen() async {
    await _preferences.setBool(SharedKeys.firstAppOpen.name, false);
  }

  bool isFirstAppOpen() {
    return _preferences.getBool(SharedKeys.firstAppOpen.name) ?? true;
  }

  Future<bool> setFavoritePlace(FavoritePlaceModel favoritePlace) async {
    final places = getFavoritePlaces()..add(favoritePlace);

    //safeJsonEncodeCompute not working for encoding..
    final jsonPlaces = places.map((place) => jsonEncode(place.toJson()));

    return _preferences.setStringList(
      SharedKeys.favoritePlaces.name,
      jsonPlaces.toList(),
    );
  }

  Future<bool> removeFromFavorites(FavoritePlaceModel favoritePlace) async {
    final places = getFavoritePlaces()
      ..removeWhere((place) => place.name == favoritePlace.name);

    //safeJsonEncodeCompute not working for encoding..
    final jsonPlaces = places.map((place) => jsonEncode(place.toJson()));

    return _preferences.setStringList(
      SharedKeys.favoritePlaces.name,
      jsonPlaces.toList(),
    );
  }

  bool isFavoritePlace(String name) {
    final place =
        getFavoritePlaces().firstWhereOrNull((element) => element.name == name);

    return place != null;
  }

  List<FavoritePlaceModel> getFavoritePlaces() {
    final places = _preferences.getStringList(SharedKeys.favoritePlaces.name);

    if (places == null) return [];

    return places.map(
      (place) {
        final json = jsonDecode(place);
        return FavoritePlaceModel.fromJson(json as Map<String, dynamic>);
      },
    ).toList();
  }
}
