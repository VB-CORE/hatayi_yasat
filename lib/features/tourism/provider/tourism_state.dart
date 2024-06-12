import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:life_shared/src/models/touristic_places_model.dart';

final class TourismState extends Equatable {
  const TourismState({
    this.placeList = const [],
    this.markerList = const [],
  });

  /// [placeList] is the list of touristic places that will be shown on the map.
  ///
  /// It fills from service response
  final List<TouristicPlaceModel> placeList;

  /// [markerList] is the list of markers that will be shown on the map.
  final List<Marker> markerList;

  /// [initialPosition] is the initial position of the map.
  ///
  /// IF there are no places, it will be the default position.
  CameraPosition get initialPosition => const CameraPosition(
        target: LatLng(36.845487, 36.221312),
        zoom: 10,
      );

  @override
  List<Object?> get props => [placeList, markerList];

  TourismState copyWith({
    List<TouristicPlaceModel>? placeList,
    List<Marker>? markerList,
  }) {
    return TourismState(
      placeList: placeList ?? this.placeList,
      markerList: markerList ?? this.markerList,
    );
  }
}
