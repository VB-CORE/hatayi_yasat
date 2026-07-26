import 'dart:async';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/main/home/provider/home_view_model.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/provider/merchant_company_sheet_state.dart';
import 'package:lifeclient/product/package/firebase/custom_functions.dart';
import 'package:lifeclient/product/utility/extension/string_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'merchant_company_sheet_view_model.g.dart';

@riverpod
final class MerchantCompanySheetViewModel
    extends _$MerchantCompanySheetViewModel
    with ProjectDependencyMixin {
  static const int _fetchLimit = 5;

  final CustomFunctions _customFunctions = CustomFunctions();

  @override
  MerchantCompanySheetState build() {
    unawaited(fetchCompanies());
    return const MerchantCompanySheetState();
  }

  Future<void> fetchCompanies() async {
    try {
      final query = ref
          .read(homeViewModelProvider.notifier)
          .fetchApprovedCollectionQuery();
      final snapshot = await query.limit(_fetchLimit).get();

      state = state.copyWith(
        companies: snapshot.docs
            .map((doc) => doc.data())
            .whereType<StoreModel>()
            .toList(),
        isFetching: false,
      );
    } on Exception {
      state = state.copyWith(isFetching: false, isError: true);
    }
  }

  Future<void> search(String term) async {
    if (!term.isValidSearchTerm) {
      state = state.copyWith(clearSearchResults: true, isSearching: false);
      return;
    }
    state = state.copyWith(isSearching: true);
    try {
      final results = await _customFunctions.searchPlaces(term);
      state = state.copyWith(searchResults: results, isSearching: false);
    } on Exception {
      state = state.copyWith(isSearching: false, isError: true);
    }
  }

  Future<StoreModel?> selectCompany(String id) {
    return appProvider.customService.getSingleData<StoreModel>(
      model: StoreModel.empty(),
      path: CollectionPaths.approvedApplications,
      id: id,
    );
  }
}
