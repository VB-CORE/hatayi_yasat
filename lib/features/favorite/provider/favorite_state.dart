import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';

final class FavoriteState extends Equatable {
  const FavoriteState({
    required this.favoritePlaces,
    this.filteredPlaces = const [],
    this.searchWord = '',
  });

  final List<StoreModel> favoritePlaces;
  final List<StoreModel> filteredPlaces;
  final String searchWord;

  @override
  List<Object> get props => [
        favoritePlaces,
        filteredPlaces,
        searchWord,
      ];

  FavoriteState copyWith({
    List<StoreModel>? favoritePlaces,
    List<StoreModel>? filteredPlaces,
    String? searchWord,
  }) {
    return FavoriteState(
      favoritePlaces: favoritePlaces ?? this.favoritePlaces,
      filteredPlaces: filteredPlaces ?? this.filteredPlaces,
      searchWord: searchWord ?? this.searchWord,
    );
  }
}
