import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/v2/sub_feature/filter_and_search/model/filter_selected.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
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

    final selectedTownValues = widget.filter.selectedTowns
        .map((e) => e.code)
        .where((e) => e != null)
        .cast<int>()
        .toList();
    final categoriesValue = productState.categoryItems
        .where((element) => selectedItemIds.contains(element.documentId))
        .map((e) => e.value)
        .toList();
    final query = appProvider.customService
        .collectionReference(
          CollectionPaths.approvedApplications,
          StoreModel.empty(),
        )
        .where(
          Filter.and(
            Filter('townCode', whereIn: selectedTownValues),
            Filter('category.value', whereIn: categoriesValue),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Result'),
      ),
      body: GeneralFirestoreListView(
        query: query,
        title: LocaleKeys.notFound_specialAgency,
        itemBuilder: (context, model) {
          return Padding(
            padding: const PagePadding.vertical6Symmetric(),
            child: ListTile(
              onTap: () {},
              title: Text(model.name),
            ),
          );
        },
        onRetry: () {},
      ),
    );
  }
}
