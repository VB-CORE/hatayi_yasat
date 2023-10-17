import 'package:equatable/equatable.dart';

class FavoritePlaceState extends Equatable {
  const FavoritePlaceState({
    required this.isLoading,
    required this.isFavorite,
  });

  final bool isLoading;
  final bool isFavorite;

  @override
  List<Object?> get props => [isLoading, isFavorite];

  FavoritePlaceState copyWith({
    bool? isLoading,
    bool? isFavorite,
  }) {
    return FavoritePlaceState(
      isLoading: isLoading ?? this.isLoading,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
