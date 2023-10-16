import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/home_module/home_detail/models/favorite_place_model.dart';
import 'package:vbaseproject/product/feature/cache/shared_keys.dart';
import 'package:vbaseproject/product/feature/cache/shared_operation/base_shared_operation.dart';

final class SharedCache {
  SharedCache._internal();
  static final SharedCache instance = SharedCache._internal();

  late final BaseSharedOperation _sharedOperation;

  Future<void> init() async {
    _sharedOperation = SharedOperation();
    await _sharedOperation.init();
  }

  Future<void> clear() async {
    await _sharedOperation.clear();
  }

  Future<void> setFirstAppOpen() async {
    await _sharedOperation.setValue(SharedKeys.firstAppOpen, false);
  }

  bool get isFirstAppOpen =>
      _sharedOperation.getValue<bool>(SharedKeys.firstAppOpen) ?? true;

  Future<void> setTheme(ThemeMode mode) async {
    await _sharedOperation.setValue<int>(SharedKeys.theme, mode.index);
  }

  ThemeMode get theme =>
      ThemeMode.values[_sharedOperation.getValue<int>(SharedKeys.theme) ?? 0];

  Future<void> saveApplyScholarshipTime() async {
    await _sharedOperation.setValue<String>(
      SharedKeys.applyScholarship,
      DateTime.now().toIso8601String(),
    );
  }

  DateTime? getApplyScholarshipTime() {
    final time = _sharedOperation.getValue<String>(SharedKeys.applyScholarship);
    if (time == null) return null;
    return DateTime.parse(time);
  }

  Future<bool> setFavoritePlace(FavoritePlaceModel favoritePlace) async {
    final places = getFavoritePlaces()..add(favoritePlace);

    //safeJsonEncodeCompute not working for encoding..
    final jsonPlaces = places.map((place) => jsonEncode(place.toJson()));

    return _sharedOperation.setStringList(
      SharedKeys.favoritePlaces,
      jsonPlaces.toList(),
    );
  }

  Future<bool> removeFromFavorites(FavoritePlaceModel favoritePlace) async {
    final places = getFavoritePlaces()
      ..removeWhere((place) => place.name == favoritePlace.name);

    //safeJsonEncodeCompute not working for encoding..
    final jsonPlaces = places.map((place) => jsonEncode(place.toJson()));

    return _sharedOperation.setStringList(
      SharedKeys.favoritePlaces,
      jsonPlaces.toList(),
    );
  }

  bool isFavoritePlace(String name) {
    final place =
        getFavoritePlaces().firstWhereOrNull((element) => element.name == name);

    return place != null;
  }

  List<FavoritePlaceModel> getFavoritePlaces() {
    final places = _sharedOperation.getStringList(SharedKeys.favoritePlaces);

    if (places == null) return [];

    return places.map(
      (place) {
        final json = jsonDecode(place);
        return FavoritePlaceModel.fromJson(json as Map<String, dynamic>);
      },
    ).toList();
  }
}
