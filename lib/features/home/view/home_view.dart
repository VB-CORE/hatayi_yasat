import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart' show ContextExtension, WidgetExtension;
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/home/provider/home_view_model.dart';
import 'package:vbaseproject/features/home/view/mixin/home_view_mixin.dart';
import 'package:vbaseproject/features/sub_feature/filter_and_search/model/filter_selected.dart';
import 'package:vbaseproject/features/sub_feature/search/place_search_delegate.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/enum/text_field/text_field_max_lengths.dart';
import 'package:vbaseproject/product/model/search_response_model.dart';
import 'package:vbaseproject/product/navigation/app_router.dart';
import 'package:vbaseproject/product/package/image/custom_network_image.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';
import 'package:vbaseproject/product/utility/decorations/custom_radius.dart';
import 'package:vbaseproject/product/utility/decorations/empty_box.dart';
import 'package:vbaseproject/product/utility/mixin/app_provider_mixin.dart';
import 'package:vbaseproject/product/utility/mixin/notification_type_mixin.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/card/general_place_card.dart';
import 'package:vbaseproject/product/widget/card/place/general_place_grid_card.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/general/list/general_firestore_list_sliver_view.dart';
import 'package:vbaseproject/product/widget/size/index.dart';
import 'package:vbaseproject/product/widget/text/clickable_title_text.dart';
import 'package:vbaseproject/product/widget/text_field/custom_search_field.dart';

part 'widget/advertisement_slider.dart';
part 'widget/home_categories_area.dart';
part 'widget/home_place_area.dart';
part 'widget/home_search_field.dart';

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
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const ClampingScrollPhysics(),
        slivers: [
          const _HomeSearchField(),
          const _AdvertisementSlider(),
          SliverPadding(
            padding: const PagePadding.onlyTopMedium(),
            sliver: ClickableSubTitleText(
              title: LocaleKeys.home_categories.tr(),
              onTap: () async {
                await pushToFilter(context: context);
              },
            ).ext.sliver,
          ),
          const SliverPadding(
            padding: PagePadding.vertical6Symmetric(),
            sliver: _HomeCategoryCards(),
          ),
          SliverPadding(
            padding:
                const PagePadding.onlyBottom() + const PagePadding.onlyTop(),
            sliver: GeneralSubTitle(
              value: LocaleKeys.home_places.tr(),
              fontWeight: FontWeight.bold,
            ).ext.sliver,
          ),
          const _HomePlacesArea(),
          const EmptyBox.largeXxHeight().ext.sliver,
        ],
      ),
    );
  }
}
