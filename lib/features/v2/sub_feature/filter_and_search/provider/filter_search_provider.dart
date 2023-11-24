import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vbaseproject/features/v2/sub_feature/filter_and_search/provider/fliter_search_state.dart';

part 'filter_search_provider.g.dart';

@riverpod
final class FilterWithSearch extends _$FilterWithSearch {
  @override
  FilterSearchState build() => FilterSearchState();
}
