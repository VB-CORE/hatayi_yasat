// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tourism_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TourismViewModel)
const tourismViewModelProvider = TourismViewModelProvider._();

final class TourismViewModelProvider
    extends $NotifierProvider<TourismViewModel, TourismState> {
  const TourismViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'tourismViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$tourismViewModelHash();

  @$internal
  @override
  TourismViewModel create() => TourismViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TourismState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TourismState>(value),
    );
  }
}

String _$tourismViewModelHash() => r'1a3aa1c912b0648a782d9fd81c718ed8292a09ff';

abstract class _$TourismViewModel extends $Notifier<TourismState> {
  TourismState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<TourismState, TourismState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<TourismState, TourismState>,
        TourismState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
