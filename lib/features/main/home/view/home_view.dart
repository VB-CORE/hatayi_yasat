import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart' show ContextExtension, WidgetExtension;
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/service/location_permission_service.dart';
import 'package:lifeclient/features/main/home/provider/home_view_model.dart';
import 'package:lifeclient/features/main/home/view/mixin/home_view_mixin.dart';
import 'package:lifeclient/features/tourism/view/tourism_map_view.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/sorting_types.dart';
import 'package:lifeclient/product/model/enum/text_field/text_field_max_lengths.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/utility/mixin/notification_type_mixin.dart';
import 'package:lifeclient/product/widget/button/index.dart';
import 'package:lifeclient/product/widget/card/general_place_card.dart';
import 'package:lifeclient/product/widget/card/place/general_place_grid_card.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/sheet/general_select_sheet.dart';
import 'package:lifeclient/product/widget/text/clickable_title_text.dart';
import 'package:lifeclient/sub_feature/advertisement_board/views/advertisement_slider.dart';

part 'widget/home_categories_area.dart';
part 'widget/home_place_area.dart';
part 'widget/home_sort_grid_view.dart';

final class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with
        NotificationTypeMixin,
        AppProviderMixin<HomeView>,
        HomeViewMixin,
        _FilterMixin {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: FloatingActionButton(
          onPressed: () async {
            final service = LocationPermissionService();
            final isGranted = await service.ensurePermission();
            if (mounted && isGranted) {
              await Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const TourismMapView(),
                ),
              );
            }
          },
        ),
      ),
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const ClampingScrollPhysics(),
        slivers: [
          const AdvertisementSlider(),
          SliverPadding(
            padding: const PagePadding.onlyTopMedium(),
            sliver: ClickableSubTitleText(
              title: LocaleKeys.home_categories.tr(),
              onTap: () => pushToFilter(context: context),
            ).ext.sliver,
          ),
          const SliverPadding(
            padding: PagePadding.vertical6Symmetric(),
            sliver: _HomeCategoryCards(),
          ),
          SliverAppBar(
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GeneralSubTitle(
                    value: LocaleKeys.home_places.tr(),
                    fontWeight: FontWeight.bold,
                  ),
                  const _HomeSortGridView(),
                ],
              ),
            ),
          ),
          const _HomePlacesArea(),
          const EmptyBox.largeXxHeight().ext.sliver,
        ],
      ),
    );
  }
}
