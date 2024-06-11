import 'package:equatable/equatable.dart';
import 'package:life_shared/src/models/touristic_places_model.dart';

final class TourismState extends Equatable {
  const TourismState({this.placeList = const []});

  final List<TouristicPlaceModel> placeList;

  @override
  List<Object?> get props => [placeList];

  TourismState copyWith({
    List<TouristicPlaceModel>? placeList,
  }) {
    return TourismState(
      placeList: placeList ?? this.placeList,
    );
  }
}
