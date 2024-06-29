part of './tourism_map_view.dart';

mixin _TourismMapStateHelper on ConsumerState<TourismMapView> {
  late GoogleMapController _mapController;
  final CarouselController _carouselController = CarouselController();

  CarouselController get carouselController => _carouselController;

  @override
  void initState() {
    super.initState();
    ref.listenManual(
      tourismViewModelProvider,
      (previous, next) async {
        if (next.selectedPlace == null) return;
        await animateToPosition(
          GeoPointConverterMixin.geoPointToLatLng(
            next.selectedPlace!.latLong,
          ),
        );
        await showMarkerInfo(next.selectedPlace!);
      },
    );
  }

  Future<void> showMarkerInfo(TouristicPlaceModel model) async {
    /// it is necessary to wait for the marker to be created
    await Future.delayed(Durations.short4, () {
      _mapController.showMarkerInfoWindow(MarkerId(model.documentId));
    });
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    ref.read(tourismViewModelProvider.notifier).fetchTouristicPlaces();
  }

  void changeSelectedPlace(TouristicPlaceModel model) {
    ref.read(tourismViewModelProvider.notifier).changeSelectedPlace(
          model,
        );
  }

  Future<void> animateToPosition(
    LatLng position,
  ) async {
    await _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(position, WidgetSizes.spacingS),
    );
  }
}
