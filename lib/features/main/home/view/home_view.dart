import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart' show ContextExtension, WidgetExtension;
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/main/home/provider/home_view_model.dart';
import 'package:lifeclient/features/main/home/view/mixin/home_view_mixin.dart';
import 'package:lifeclient/features/sub_feature/search/place_search_delegate.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/sorting_types.dart';
import 'package:lifeclient/product/model/search_response_model.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
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
        _FilterMixin,
        AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GeneralScaffold(
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const ClampingScrollPhysics(),
        slivers: [
          const AdvertisementSlider(),
          SliverAppBar(
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              centerTitle: false,
              title: Row(
                children: [
                  GeneralBigTitle(
                    LocaleKeys.home_places.tr(),
                    key: ValueKey(context.locale),
                  ),
                  const Spacer(),
                  const _HomeSortGridView(),
                ],
              ),
            ),
          ),
          SliverList.list(
            children: [
              Padding(
                padding: const PagePadding.vertical12Symmetric(),
                child: Row(
                  children: [
                    const Expanded(
                      child: _CustomSearchField(),
                    ),
                    Padding(
                      padding: const PagePadding.onlyLeft(),
                      child: _FilterButton(
                        onTap: () => pushToFilter(context: context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const _CategoriesItems(),
          const _HomePlaceArea(),
          const EmptyBox.largeXxHeight().ext.sliver,
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

final class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: context.general.colorScheme.onPrimaryFixed,
        shape: RoundedRectangleBorder(
          borderRadius: CustomRadius.large,
          side: BorderSide(
            color: context.general.colorScheme.onPrimaryFixed,
          ),
        ),
      ),
      child: Padding(
        padding: const PagePadding.generalAllLow(),
        child: Icon(
          AppIcons.filter,
          color: context.general.colorScheme.onSecondaryFixed,
        ),
      ),
    );
  }
}

final class _CustomSearchField extends StatelessWidget {
  const _CustomSearchField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () async {
        await showSearch<SearchResponse>(
          context: context,
          delegate: PlaceSearchDelegate(),
        );
      },
      decoration: InputDecoration(
        hintText: LocaleKeys.search_place.tr(),
        focusColor: context.general.colorScheme.onPrimaryFixed,
        focusedBorder: OutlineInputBorder(
          borderRadius: CustomRadius.large,
          borderSide: BorderSide(
            color: context.general.colorScheme.onPrimaryFixed,
          ),
        ),
        hintStyle: context.general.textTheme.titleMedium?.copyWith(
          color: context.general.colorScheme.onSecondaryFixed,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: CustomRadius.large,
          borderSide: BorderSide(
            color: context.general.colorScheme.onPrimaryFixed,
          ),
        ),
        filled: true,
        fillColor: context.general.colorScheme.onPrimaryFixed,
        contentPadding: const PagePadding.horizontalSymmetric(),
        prefixIcon: Icon(
          AppIcons.search,
          color: context.general.colorScheme.onSecondaryFixed,
        ),
      ),
    );
  }
}

final class _CategoriesItems extends ConsumerWidget {
  const _CategoriesItems();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasCategories =
        ref.watch(homeViewModelProvider).categories.isNotEmpty;
    if (!hasCategories) {
      return const SliverToBoxAdapter(
        child: SizedBox.shrink(),
      );
    }
    return const SliverPadding(
      padding: PagePadding.vertical6Symmetric(),
      sliver: _HomeCategoryCards(),
    );
  }
}
