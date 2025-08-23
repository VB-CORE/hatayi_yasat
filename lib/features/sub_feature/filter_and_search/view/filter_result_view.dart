import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/model/filter_selected_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/package/firebase/filter/general_category_town_filter.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/mixin/index.dart';
import 'package:lifeclient/product/widget/card/place/general_place_grid_card.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';

final class FilterResultView extends ConsumerStatefulWidget {
  const FilterResultView({required this.filter, super.key});

  final FilterSelected filter;
  @override
  ConsumerState<FilterResultView> createState() => _FilterResultViewState();
}

class _FilterResultViewState extends ConsumerState<FilterResultView>
    with AppProviderMixin {
  @override
  Widget build(BuildContext context) {
    final query = appProvider.customService
        .collectionReference(
          CollectionPaths.approvedApplications,
          StoreModel.empty(),
        )
        .where(
          GeneralCategoryTownFilter(
            selectedCategories: widget.filter.selectedCategories,
            selectedTowns: widget.filter.selectedTowns,
          ).make(categoryItems: productState.categoryItems),
        );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: false,
            title: Text(
              LocaleKeys.component_filter_filterResult.tr(),
            ),
          ),
          SliverPadding(
            padding: const PagePadding.horizontalSymmetric(),
            sliver: FirestoreSliverListView(
              query: query,
              emptyBuilder: (context) => GeneralNotFoundWidget(
                title: LocaleKeys.component_filter_resultEmpty.tr(),
              ),
              itemBuilder: (context, model) {
                return const SizedBox.shrink();
              },
              isGridDesign: true,
              onRetry: () {},
              itemGridBuilder: (BuildContext context, StoreModel model) {
                return Padding(
                  padding: const PagePadding.onlyBottom(),
                  child: GeneralPlaceGridCard(
                    elevation: kZero,
                    isEnabledToFavorite: false,
                    onCardTap: () {
                      PlaceDetailRoute($extra: model, id: model.documentId)
                          .push<void>(this.context);
                    },
                    storeModel: model,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
