import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart' show ContextExtension;
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/model/filter_selected_model.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/provider/filter_search_provider.dart';
import 'package:lifeclient/features/sub_feature/filter_and_search/view/mixin/filter_search_view_mixin.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/button/model/multiple_select_item_model.dart';
import 'package:lifeclient/product/widget/button/multiple_select_button.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/scrollbar/product_scroll_bar.dart';

part './widget/filter_search_button.dart';
part './widget/filter_search_categories.dart';
part './widget/filter_search_category_header.dart';
part './widget/filter_search_clear_all.dart';
part './widget/filter_search_towns.dart';
part './widget/filter_search_towns_header.dart';

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
    return GeneralScaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        titleSpacing: kZero,
        title: const _FilterSearchClearAll(),
        actions: const [
          CloseButton(),
        ],
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FilterSearchCategoryHeader(),
          Divider(),
          Expanded(
            flex: 2,
            child: _FilterSearchCategories(),
          ),
          _FilterSearchTownsHeader(),
          Divider(),
          Expanded(
            flex: 2,
            child: _FilterSearchTowns(),
          ),
          _FilterSearchButton(),
        ],
      ),
    );
  }
}
