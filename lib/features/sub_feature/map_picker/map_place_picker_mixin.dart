import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lifeclient/features/sub_feature/map_picker/map_place_picker.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';

mixin MapPlacePickerMixin on State<MapPlacePicker> {
  late final ValueNotifier<MapPickerState> pickerStateNotifier;
  late final CameraPosition initialCameraPosition;
  final String selectedLocationId = 'selectedLocation';

  @override
  void initState() {
    super.initState();
    initialCameraPosition = CameraPosition(
      target: widget.initialPosition ?? AppConstants.initialLocation.target,
      zoom: 12,
    );
    pickerStateNotifier = ValueNotifier(
      MapPickerState(
        selectedLocation: widget.initialPosition,
        isMapCreated: false,
      ),
    );
  }

  MapPickerState get _value => pickerStateNotifier.value;
  LatLng? get _latLng => _value.selectedLocation;
  bool get isMapCreated => _value.isMapCreated;

  /// Called when the user taps on the map. [location]
  void onTappedFromMap(LatLng location) {
    pickerStateNotifier.value = _value.copyWith(
      selectedLocation: location,
    );
  }

  /// Called when the map is created.
  void onGoogleMapCreated() {
    pickerStateNotifier.value = _value.copyWith(
      isMapCreated: true,
    );
  }

  /// Completes the selection of a location.
  void completeSelection() {
    final selectedLocation = _latLng;
    if (selectedLocation == null) return;
    context.pop(selectedLocation);
  }
}

final class MapPickerState {
  const MapPickerState({
    required this.selectedLocation,
    required this.isMapCreated,
  });
  final LatLng? selectedLocation;
  final bool isMapCreated;

  MapPickerState copyWith({
    LatLng? selectedLocation,
    bool? isMapCreated,
  }) {
    return MapPickerState(
      selectedLocation: selectedLocation ?? this.selectedLocation,
      isMapCreated: isMapCreated ?? this.isMapCreated,
    );
  }
}
