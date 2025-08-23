// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(HistoryViewModel)
const historyViewModelProvider = HistoryViewModelProvider._();

final class HistoryViewModelProvider
    extends $NotifierProvider<HistoryViewModel, HistoryState> {
  const HistoryViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'historyViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$historyViewModelHash();

  @$internal
  @override
  HistoryViewModel create() => HistoryViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HistoryState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HistoryState>(value),
    );
  }
}

String _$historyViewModelHash() => r'70a24569cf3c85e08e500b47c73b64bce533013d';

abstract class _$HistoryViewModel extends $Notifier<HistoryState> {
  HistoryState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<HistoryState, HistoryState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<HistoryState, HistoryState>,
        HistoryState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
