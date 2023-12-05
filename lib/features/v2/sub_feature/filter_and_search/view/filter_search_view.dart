import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/v2/sub_feature/filter_and_search/provider/filter_search_provider.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';
import 'package:vbaseproject/product/widget/animated/animated_page_change.dart';
import 'package:vbaseproject/product/widget/button/multiple_select_button.dart';
import 'package:vbaseproject/product/widget/general/general_button.dart';
import 'package:vbaseproject/product/widget/general/general_check_box.dart';
import 'package:vbaseproject/product/widget/general/general_scaffold.dart';

part './widget/filter_search_button.dart';
part './widget/filter_search_categories.dart';
part './widget/filter_search_category_header.dart';
part './widget/filter_search_clear_all.dart';
part './widget/filter_search_towns.dart';
part './widget/filter_search_towns_header.dart';

final class FilterSearchView extends ConsumerStatefulWidget {
  const FilterSearchView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FilterSearchViewState();
}

class _FilterSearchViewState extends ConsumerState<FilterSearchView> {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
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
