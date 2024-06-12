import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/tourism/mixin/geo_point_converter_mixin.dart';
import 'package:lifeclient/features/tourism/provider/tourism_state.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tourism_view_model.g.dart';

@riverpod
final class TourismViewModel extends _$TourismViewModel
    with ProjectDependencyMixin, GeoPointConverterMixin {
  TourismViewModel() {
    _carouselController = CarouselController();
  }

  @override
  TourismState build() => const TourismState();

  GoogleMapController? _mapController;

  late final CarouselController _carouselController;
  CarouselController get carouselController => _carouselController;

  Future<void> fetchTouristicPlaces() async {
    final placeListResponse =
        await firebaseService.getList<TouristicPlaceModel>(
      model: TouristicPlaceModel(),
      path: CollectionPaths.touristicPlaces,
    );

    state = state.copyWith(
      placeList: placeListResponse,
      markerList: _createMarkerList(placeListResponse),
    );

    if (placeListResponse.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        animateToPosition(
          geoPointToLatLng(placeListResponse.first.latLong),
          zoom: 9,
        );
      });
    }
  }

  List<Marker> _createMarkerList(List<TouristicPlaceModel> placeList) =>
      placeList.map(_buildMarker).toList();

  Marker _buildMarker(TouristicPlaceModel model) {
    return Marker(
      markerId: MarkerId(model.documentId),
      position: geoPointToLatLng(model.latLong),
      infoWindow: InfoWindow(
        title: model.title,
        snippet: LocaleKeys.tourismView_onTapMarkerWindow.tr(),
        onTap: () => _onMarkerWindowTap(
          latlng: geoPointToLatLng(model.latLong),
        ),
      ),
    );
  }

  void _onMarkerWindowTap({required LatLng latlng}) {
    '${latlng.latitude},${latlng.longitude}'.ext.launchMaps();
  }

  // ?TODO: we can add this in analysis options
  // ignore: use_setters_to_change_properties
  void onMapCreated(GoogleMapController controller) =>
      _mapController = controller;

  void animateToPosition(
    LatLng position, {
    double zoom = WidgetSizes.spacingXsMid,
  }) {
    _mapController?.animateCamera(CameraUpdate.newLatLngZoom(position, zoom));
  }
}
