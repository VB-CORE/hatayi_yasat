import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/model/filter_selected_model.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/provider/filter_search_provider.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/view/mixin/filter_search_view_mixin.dart';
import 'package:lifeclient/product/init/application_theme.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/brand/eyebrow.dart';
import 'package:lifeclient/product/widget/button/model/multiple_select_item_model.dart';
import 'package:lifeclient/product/widget/general/index.dart';

part './widget/filter_search_button.dart';
part './widget/filter_search_categories.dart';
part './widget/filter_search_category_header.dart';
part './widget/filter_search_clear_all.dart';
part './widget/filter_search_towns.dart';
part './widget/filter_search_towns_header.dart';

/// V2 filter sheet. Layout follows the V3 design handoff:
///
/// - Header: clear (left) · Filtre title (center) · close (right)
/// - "Ne arıyorsun?" categories — V2 chips with check / + icon
/// - "Nerede?" districts — V2 checkbox rows with active accent
/// - Sticky bottom CTA "Sonuçları göster (N)"
final class FilterSearchView extends ConsumerStatefulWidget {
  const FilterSearchView({
    super.key,
    this.selectedCategoryId,
  });

  final String? selectedCategoryId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FilterSearchViewState();
}

class _FilterSearchViewState extends ConsumerState<FilterSearchView>
    with AppProviderMixin<FilterSearchView>, FilterSearchViewMixin {
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.general.colorScheme;
    return GeneralScaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.secondary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: const _FilterSearchClearAll(),
        leadingWidth: 92,
        title: Text(
          LocaleKeys.component_filter_title.tr(),
          style: V2Typography.display(
            fontSize: 19,
            color: colorScheme.primary,
          ),
        ),
        actions: const [
          CloseButton(),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: SingleChildScrollView(
              padding: PagePadding.allLow(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EmptyBox.smallHeight(),
                  _FilterSearchCategoryHeader(),
                  EmptyBox.smallHeight(),
                  _FilterSearchCategories(),
                  EmptyBox.largeHeight(),
                  _FilterSearchTownsHeader(),
                  EmptyBox.smallHeight(),
                  _FilterSearchTowns(),
                  EmptyBox.largeHeight(),
                ],
              ),
            ),
          ),
          const _FilterSearchButton(),
        ],
      ),
    );
  }
}
