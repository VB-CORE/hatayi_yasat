import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';

final class FavoriteState extends Equatable {
  const FavoriteState({
    required this.favoritePlaces,
    this.filteredPlaces = const [],
  });
  final List<StoreModel> favoritePlaces;

  final List<StoreModel> filteredPlaces;
  @override
  List<Object> get props => [
        favoritePlaces,
        filteredPlaces,
      ];

  FavoriteState copyWith({
    List<StoreModel>? favoritePlaces,
    List<StoreModel>? filteredPlaces,
  }) {
    return FavoriteState(
      favoritePlaces: favoritePlaces ?? this.favoritePlaces,
      filteredPlaces: filteredPlaces ?? this.filteredPlaces,
    );
  }
}
