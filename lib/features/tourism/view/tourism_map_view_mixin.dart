part of './tourism_map_view.dart';

mixin _TourismMapStateHelper on ConsumerState<TourismMapView> {
  late GoogleMapController _mapController;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  CarouselSliderController get carouselController => _carouselController;
  late BitmapDescriptor _markerIcon;

  Set<Marker> get markers {
    return Set.from(
      ref
          .watch(tourismViewModelProvider)
          .placeList
          .map((e) => ToursimCustomMarker(model: e, icon: _markerIcon)),
    );
  }

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

  Future<void> _loadCustomMarker() async {
    _markerIcon = await BitmapDescriptor.asset(
      ImageConfiguration.empty,
      Assets.icons.icAppTransparent.path,
      height: WidgetSizes.spacingXl,
      width: WidgetSizes.spacingXl,
    );
  }

  Future<void> showMarkerInfo(TouristicPlaceModel model) async {
    /// it is necessary to wait for the marker to be created
    await Future.delayed(Durations.short4, () {
      _mapController.showMarkerInfoWindow(MarkerId(model.documentId));
    });
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    await _loadCustomMarker();
    await ref.read(tourismViewModelProvider.notifier).fetchTouristicPlaces();
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
