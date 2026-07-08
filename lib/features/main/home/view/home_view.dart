import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart' show WidgetExtension;
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_shadows.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/main/home/provider/home_view_model.dart';
import 'package:lifeclient/features/main/home/view/mixin/home_view_mixin.dart';
import 'package:lifeclient/features/main/home/view/widget/place_filter_sheet.dart';
import 'package:lifeclient/features/sub_feature/search/place_search_delegate.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/search_response_model.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/category_visual.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/utility/mixin/notification_type_mixin.dart';
import 'package:lifeclient/product/utility/mock/place_meta_mock.dart';
import 'package:lifeclient/product/widget/card/general_place_card.dart';
import 'package:lifeclient/product/widget/card/place/general_place_grid_card.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/sheet/place_sort_sheet.dart';
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
          const _HomeHeaderBlock(),
          const _SearchFilterRow(),
          const _ActiveFilterBar(),
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

final class _HomeHeaderBlock extends ConsumerWidget {
  const _HomeHeaderBlock();

  static const _otherCategoryValue = 1000;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final city = ref
        .watch(ProjectDependencyItems.productProviderState)
        .selectedCity
        .description;
    final categoryValues = ref
        .watch(homeViewModelProvider)
        .categories
        .where((e) => e.value != _otherCategoryValue)
        .map((e) => e.value);
    final total = CategoryCountMock.total(categoryValues);

    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      sliver: SliverToBoxAdapter(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${city.toUpperCase()} · $total '
                    '${LocaleKeys.home_placesUpper.tr()}',
                    style: AppText.eyebrow,
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    LocaleKeys.home_places.tr(),
                    key: ValueKey('homePlacesTitle_${context.locale}'),
                    style: AppText.displayMd,
                  ),
                ],
              ),
            ),
            const _HomeSortGridView(),
          ],
        ),
      ),
    );
  }
}

final class _SearchFilterRow extends StatelessWidget {
  const _SearchFilterRow();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.md,
            children: [
              const Expanded(child: _CustomSearchField()),
              _FilterButton(
                onTap: () => PlaceFilterSheet.show(context),
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
    return SizedBox(
      width: 48,
      child: Stack(
        children: [
          Positioned.fill(
            child: Material(
              color: AppColors.ink50,
              borderRadius: BorderRadius.circular(AppRadius.md),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                key: const Key('homeFilterButton'),
                onTap: onTap,
                child: const Center(
                  child: Icon(AppIcons.filter, color: AppColors.ink500),
                ),
              ),
            ),
          ),
          Positioned(
            top: AppSpacing.xs,
            right: AppSpacing.xs,
            child: Container(
              width: AppSpacing.xs,
              height: AppSpacing.xs,
              decoration: const BoxDecoration(
                color: AppColors.coral,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class _CustomSearchField extends StatelessWidget {
  const _CustomSearchField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('homeSearchField'),
      readOnly: true,
      onTap: () async {
        await showSearch<SearchResponse>(
          context: context,
          delegate: PlaceSearchDelegate(),
        );
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.ink50,
        hintText: LocaleKeys.search_place.tr(),
        hintStyle: AppText.body.copyWith(color: AppColors.ink400),
        prefixIcon: const Icon(AppIcons.search, color: AppColors.ink400),
        border: _searchBorder,
        enabledBorder: _searchBorder,
        focusedBorder: _searchBorder,
      ),
    );
  }

  OutlineInputBorder get _searchBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: BorderSide.none,
      );
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

final class _ActiveFilterBar extends ConsumerWidget {
  const _ActiveFilterBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);
    if (!state.hasActiveFilters) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    final parts = <String>[
      if (state.categoryValues.isNotEmpty)
        LocaleKeys.filter_categoryCountLabel.tr(
          args: ['${state.categoryValues.length}'],
        ),
      if (state.townCodes.isNotEmpty)
        LocaleKeys.filter_districtCountLabel.tr(
          args: ['${state.townCodes.length}'],
        ),
      if (state.openNow) LocaleKeys.filter_openShort.tr(),
      if (state.favoritesOnly) LocaleKeys.filter_favoritesShort.tr(),
    ];

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Row(
          children: [
            Expanded(
              child: Material(
                color: AppColors.coral50,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  onTap: () => PlaceFilterSheet.show(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          AppIcons.filter,
                          size: 16,
                          color: AppColors.coral,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            parts.join(' · '),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppText.caption.copyWith(
                              color: AppColors.coral700,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            InkWell(
              onTap: () =>
                  ref.read(homeViewModelProvider.notifier).clearFilters(),
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: const Padding(
                padding: EdgeInsets.all(AppSpacing.xs),
                child: Icon(AppIcons.close, size: 18, color: AppColors.ink500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
