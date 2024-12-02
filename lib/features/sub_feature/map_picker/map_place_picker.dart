import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/map_picker/map_place_picker_mixin.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/decorations/colors_custom.dart';
import 'package:lifeclient/product/widget/general/index.dart';

part 'widget/city_center_text_button.dart';

class MapPlacePicker extends StatefulWidget {
  const MapPlacePicker({super.key, this.initialPosition});

  final LatLng? initialPosition;

  @override
  State<MapPlacePicker> createState() => _MapPlacePickerState();
}

class _MapPlacePickerState extends State<MapPlacePicker>
    with MapPlacePickerMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.component_mapPicker_title).tr(),
      ),
      body: ValueListenableBuilder<MapPickerState>(
        valueListenable: pickerStateNotifier,
        builder: (context, state, child) {
          return Stack(
            children: [
              GoogleMap(
                onTap: onTappedFromMap,
                onMapCreated: onGoogleMapCreated,
                initialCameraPosition: initialCameraPosition,
                myLocationButtonEnabled: false,
                markers: {
                  if (state.selectedLocation != null)
                    Marker(
                      markerId: MarkerId(selectedLocationId),
                      position: state.selectedLocation!,
                    ),
                },
              ),
              Positioned(
                top: WidgetSizes.spacingL,
                left: WidgetSizes.spacingXsMid,
                child: _CityCenterTextButton(
                  text: AppConstants.hatay,
                  onPressed: moveToHatay,
                ),
              ),
              Positioned(
                top: WidgetSizes.spacingXxl9,
                left: WidgetSizes.spacingXsMid,
                child: _CityCenterTextButton(
                  text: AppConstants.mersin,
                  onPressed: moveToMersin,
                ),
              ),
              Positioned(
                bottom: WidgetSizes.spacingMx,
                right: WidgetSizes.spacingMx,
                left: WidgetSizes.spacingMx,
                child: GeneralButtonV2.active(
                  label:
                      LocaleKeys.component_mapPicker_selectedLocationSave.tr(),
                  action: completeSelection,
                  isEnabled: state.selectedLocation != null,
                ),
              ),
              if (!state.isMapCreated)
                Center(child: Assets.lottie.loadingGray.lottie()),
            ],
          );
        },
      ),
    );
  }
}
