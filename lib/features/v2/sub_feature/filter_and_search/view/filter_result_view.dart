import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/v2/sub_feature/filter_and_search/model/filter_selected.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/navigation/app_router.dart';
import 'package:vbaseproject/product/package/firebase/filter/category_code_filter.dart';
import 'package:vbaseproject/product/package/firebase/filter/town_code_filter.dart';
import 'package:vbaseproject/product/utility/mixin/index.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/general/list/general_firestore_list_view.dart';

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
    final selectedItemIds = widget.filter.selectedCategories.map((e) => e.id);
    final selectedTownValues = _selectedTownIds();
    final categoriesValue = _selectedCategories(selectedItemIds);

    final query = appProvider.customService
        .collectionReference(
          CollectionPaths.approvedApplications,
          StoreModel.empty(),
        )
        .where(
          Filter.and(
            TownCodeFilter(selectedTownValues),
            CategoryCodeFilter(categoriesValue),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(LocaleKeys.component_filter_filterResult).tr(),
      ),
      body: GeneralFirestoreListView(
        query: query,
        title: LocaleKeys.notFound_specialAgency,
        itemBuilder: (context, model) {
          return Padding(
            padding: const PagePadding.vertical6Symmetric(),
            child: ListTile(
              onTap: () {
                context.pop();
                PlaceDetailRoute($extra: model).go(context);
              },
              title: Text(model.name),
            ),
          );
        },
        onRetry: () {},
      ),
    );
  }

  List<int> _selectedTownIds() {
    final selectedTownValues = widget.filter.selectedTowns
        .map((e) => e.code)
        .where((e) => e != null)
        .cast<int>()
        .toList();
    return selectedTownValues;
  }

  List<int> _selectedCategories(Iterable<String> selectedItemIds) {
    final categoriesValue = productState.categoryItems
        .where((element) => selectedItemIds.contains(element.documentId))
        .map((e) => e.value)
        .toList();
    return categoriesValue;
  }
}
