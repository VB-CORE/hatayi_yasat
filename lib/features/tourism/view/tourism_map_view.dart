import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_shadows.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/tourism/mixin/geo_point_converter_mixin.dart';
import 'package:lifeclient/features/tourism/provider/tourism_view_model.dart';
import 'package:lifeclient/features/tourism/widgets/toursim_custom_marker.dart';
import 'package:lifeclient/features/tourism/widgets/toursim_place_detail_sheet.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/link_actions.dart';
import 'package:lifeclient/product/widget/background/mosaic_background.dart';
import 'package:lifeclient/product/widget/button/outline_action_button.dart';
import 'package:lifeclient/product/widget/general/index.dart';

part '../widgets/tourism_place_card.dart';
part '../widgets/tourism_places_slider.dart';
part '../widgets/tourist_top_bar.dart';
part 'tourism_map_view_mixin.dart';

final class TourismMapView extends ConsumerStatefulWidget {
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
            myLocationButtonEnabled: false,
            onMapCreated: onMapCreated,
            markers: markers,
            myLocationEnabled: true,
            initialCameraPosition: AppConstants.initialLocation,
          ),
          const _TouristTopBar(),
          Positioned(
            bottom: WidgetSizes.spacingXsMid,
            left: kZero,
            right: kZero,
            child: SafeArea(
              child: _TourismPlacesSlider(
                carouselController: carouselController,
                onItemTap: changeSelectedPlace,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
