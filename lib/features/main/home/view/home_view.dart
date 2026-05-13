import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart' show ContextExtension, WidgetExtension;
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/main/home/provider/home_view_model.dart';
import 'package:lifeclient/features/main/home/view/mixin/home_view_mixin.dart';
import 'package:lifeclient/features/sub_feature/search/place_search_delegate.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/sorting_types.dart';
import 'package:lifeclient/product/model/search_response_model.dart';
import 'package:lifeclient/product/model/social/sample_social_data.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/utility/mixin/notification_type_mixin.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';
import 'package:lifeclient/product/widget/button/index.dart';
import 'package:lifeclient/product/widget/card/v2_place_card.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/sheet/general_select_sheet.dart';
import 'package:lifeclient/product/widget/sheet/v2_discover_menu.dart';
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
      key: const Key('homeView'),
      body: CustomScrollView(
        key: const Key('homeScrollView'),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const ClampingScrollPhysics(),
        slivers: [
          const AdvertisementSlider(),
          const SliverToBoxAdapter(child: _HomeTitleHeader()),
          SliverList.list(
            children: [
              Padding(
                key: const Key('homeSearchFilterRow'),
                padding:
                    const PagePadding.vertical12Symmetric() +
                    const PagePadding.horizontalVeryLowSymmetric(),
                child: Row(
                  children: [
                    const Expanded(child: _CustomSearchField()),
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

/// V2 mozaik home title — eyebrow ("Aktif şehir · {city}") plus a
/// DM Serif "Mekanlar" display heading, with the existing grid/list
/// toggle anchored to the right. Replaces the prior `SliverAppBar`
/// pinned header.
final class _HomeTitleHeader extends ConsumerWidget {
  const _HomeTitleHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.general.colorScheme;
    final selectedCity = ref
        .watch(ProjectDependencyItems.productProviderState)
        .selectedCity;
    final cityName = selectedCity.name.isEmpty ? '—' : selectedCity.name;
    return Padding(
      key: ValueKey('homeTitleHeader_${context.locale}'),
      padding: const EdgeInsets.fromLTRB(16, 12, 12, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Eyebrow(
                  LocaleKeys.home_eyebrow.tr(
                    namedArgs: {'city': cityName},
                  ),
                ),
                const EmptyBox.xSmallHeight(),
                Text(
                  LocaleKeys.home_places.tr(),
                  style: V2Typography.display(
                    fontSize: 26,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const _DiscoverButton(),
          const EmptyBox(width: 6),
          const _HomeSortGridView(),
        ],
      ),
    );
  }
}

/// V3 Keşfet button on the home header — opens the [showV2DiscoverMenu]
/// overlay so the user can jump straight to Özel Kurumlar / Konteyner
/// Çarşılar / Turistik Yerler / Faydalı Linkler without leaving home.
final class _DiscoverButton extends StatelessWidget {
  const _DiscoverButton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return Material(
      color: colorScheme.error.withValues(alpha: 0.10),
      borderRadius: CustomRadius.medium,
      child: InkWell(
        key: const Key('homeDiscoverButton'),
        onTap: () => showV2DiscoverMenu(context),
        borderRadius: CustomRadius.medium,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.explore_rounded,
                size: 16,
                color: colorScheme.error,
              ),
              const EmptyBox(width: 6),
              Text(
                LocaleKeys.home_discoverCta.tr(),
                style: textTheme.labelMedium?.copyWith(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return Material(
      color: colorScheme.secondary,
      borderRadius: CustomRadius.medium,
      child: InkWell(
        key: const Key('homeFilterButton'),
        onTap: onTap,
        borderRadius: CustomRadius.medium,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: colorScheme.secondary,
            border: Border.all(color: colorScheme.onPrimaryContainer),
            borderRadius: CustomRadius.medium,
          ),
          child: Icon(
            Icons.tune_rounded,
            color: colorScheme.primary,
            size: 20,
          ),
        ),
      ),
    );
  }
}

final class _CustomSearchField extends StatelessWidget {
  const _CustomSearchField();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    final textTheme = context.general.textTheme;
    return InkWell(
      key: const Key('homeSearchField'),
      onTap: () async {
        await showSearch<SearchResponse>(
          context: context,
          delegate: PlaceSearchDelegate(),
        );
      },
      borderRadius: CustomRadius.medium,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          border: Border.all(color: colorScheme.onPrimaryContainer),
          borderRadius: CustomRadius.medium,
        ),
        child: Row(
          children: [
            Icon(
              Icons.search_rounded,
              size: 18,
              color: colorScheme.onSecondaryFixed,
            ),
            const EmptyBox(width: 10),
            Text(
              LocaleKeys.search_place.tr(),
              style: textTheme.bodySmall?.copyWith(
                fontSize: 13,
                color: colorScheme.onSecondaryFixed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _CategoriesItems extends ConsumerWidget {
  const _CategoriesItems();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasCategories = ref
        .watch(homeViewModelProvider)
        .categories
        .isNotEmpty;
    if (!hasCategories) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
    return const SliverPadding(
      key: ValueKey('homeCategoriesSection'),
      padding: PagePadding.vertical6Symmetric(),
      sliver: _HomeCategoryCards(),
    );
  }
}
