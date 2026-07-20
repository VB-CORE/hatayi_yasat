import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/model/search_response_model.dart';

final class MerchantCompanySheetState extends Equatable {
  const MerchantCompanySheetState({
    this.companies = const [],
    this.searchResults,
    this.isFetching = true,
    this.isSearching = false,
    this.isError = false,
  });

  final List<StoreModel> companies;
  final List<SearchResponse>? searchResults;
  final bool isFetching;
  final bool isSearching;
  final bool isError;

  @override
  List<Object?> get props => [
    companies,
    searchResults,
    isFetching,
    isSearching,
    isError,
  ];

  MerchantCompanySheetState copyWith({
    List<StoreModel>? companies,
    List<SearchResponse>? searchResults,
    bool clearSearchResults = false,
    bool? isFetching,
    bool? isSearching,
    bool? isError,
  }) {
    return MerchantCompanySheetState(
      companies: companies ?? this.companies,
      searchResults: clearSearchResults
          ? null
          : (searchResults ?? this.searchResults),
      isFetching: isFetching ?? this.isFetching,
      isSearching: isSearching ?? this.isSearching,
      isError: isError ?? this.isError,
    );
  }
}
