import 'package:vbaseproject/features/home_module/home_detail/models/favorite_place_model.dart';
import 'package:vbaseproject/product/widget/button/favorite_button/favorite_place_state.dart';

class FavoritePlacesState extends FavoritePlaceState {
  const FavoritePlacesState({
    required super.isLoading,
    required super.isFavorite,
    required this.favoritePlaces,
  });

  FavoritePlacesState.initial()
      : this(
          favoritePlaces: [],
          isFavorite: false,
          isLoading: false,
        );

  final List<FavoritePlaceModel> favoritePlaces;

  @override
  List<Object?> get props => [
        super.isFavorite,
        super.isLoading,
        favoritePlaces,
      ];

  @override
  FavoritePlacesState copyWith({
    bool? isLoading,
    bool? isFavorite,
    List<FavoritePlaceModel>? favoritePlaces,
  }) {
    return FavoritePlacesState(
      isLoading: isLoading ?? super.isLoading,
      isFavorite: isFavorite ?? super.isFavorite,
      favoritePlaces: favoritePlaces ?? this.favoritePlaces,
    );
  }
}
