import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/tourism/mixin/geo_point_converter_mixin.dart';
import 'package:lifeclient/features/tourism/provider/tourism_view_model.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/box_decorations.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';

part '../widgets/tourism_place_card.dart';
part '../widgets/tourism_places_slider.dart';

class TourismMapView extends ConsumerStatefulWidget {
  const TourismMapView({super.key});

  @override
  ConsumerState<TourismMapView> createState() => _TourismMapViewState();
}

class _TourismMapViewState extends ConsumerState<TourismMapView>
    with _TourismMapStateHelper {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (controller) => ref
                .read(tourismViewModelProvider.notifier)
                .onMapCreated(controller),
            markers: Set.from(ref.watch(tourismViewModelProvider).markerList),
            myLocationEnabled: true,
            initialCameraPosition:
                ref.read(tourismViewModelProvider).initialPosition,
          ),
          Positioned(
            left: WidgetSizes.spacingXl,
            top: WidgetSizes.spacingXxl4,
            child: CircleAvatar(
              backgroundColor: context.general.colorScheme.onTertiary,
              child: const BackButton(),
            ),
          ),
          Positioned(
            bottom: WidgetSizes.spacingL,
            left: kZero,
            right: kZero,
            child: _TourismPlacesSlider(
              carouselController: ref
                  .read(tourismViewModelProvider.notifier)
                  .carouselController,
              locations: ref.watch(tourismViewModelProvider).placeList,
              onItemTap: (LatLng latlng) => ref
                  .read(tourismViewModelProvider.notifier)
                  .animateToPosition(latlng, zoom: WidgetSizes.spacingS),
            ),
          ),
        ],
      ),
    );
  }
}

mixin _TourismMapStateHelper on ConsumerState<TourismMapView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(tourismViewModelProvider.notifier).fetchTouristicPlaces();
    });
  }
}
