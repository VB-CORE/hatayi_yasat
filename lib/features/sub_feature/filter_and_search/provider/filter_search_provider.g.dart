// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(FilterWithSearch)
const filterWithSearchProvider = FilterWithSearchProvider._();

final class FilterWithSearchProvider
    extends $NotifierProvider<FilterWithSearch, FilterSearchState> {
  const FilterWithSearchProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'filterWithSearchProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$filterWithSearchHash();

  @$internal
  @override
  FilterWithSearch create() => FilterWithSearch();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FilterSearchState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FilterSearchState>(value),
    );
  }
}

String _$filterWithSearchHash() => r'9259200dda6704d15bb4b0ad7f2317f8d969c4ae';

abstract class _$FilterWithSearch extends $Notifier<FilterSearchState> {
  FilterSearchState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FilterSearchState, FilterSearchState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<FilterSearchState, FilterSearchState>,
        FilterSearchState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
