import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';

final class TourismState extends Equatable {
  const TourismState({
    this.placeList = const [],
    this.selectedPlace,
  });

  /// [placeList] is the list of touristic places that will be shown on the map.
  ///
  /// It fills from service response
  final List<TouristicPlaceModel> placeList;

  /// [selectedPlace] is the selected place that will be shown on the map.
  ///
  final TouristicPlaceModel? selectedPlace;

  @override
  List<Object?> get props => [placeList, selectedPlace];

  TourismState copyWith({
    List<TouristicPlaceModel>? placeList,
    TouristicPlaceModel? selectedPlace,
  }) {
    return TourismState(
      placeList: placeList ?? this.placeList,
      selectedPlace: selectedPlace ?? this.selectedPlace,
    );
  }
}
