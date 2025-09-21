// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'special_agency_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SpecialAgencyViewModel)
const specialAgencyViewModelProvider = SpecialAgencyViewModelProvider._();

final class SpecialAgencyViewModelProvider
    extends $NotifierProvider<SpecialAgencyViewModel, SpecialAgencyState> {
  const SpecialAgencyViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'specialAgencyViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$specialAgencyViewModelHash();

  @$internal
  @override
  SpecialAgencyViewModel create() => SpecialAgencyViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SpecialAgencyState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SpecialAgencyState>(value),
    );
  }
}

String _$specialAgencyViewModelHash() =>
    r'71abdd0c7be2646c260103a85b835a331996e70a';

abstract class _$SpecialAgencyViewModel extends $Notifier<SpecialAgencyState> {
  SpecialAgencyState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SpecialAgencyState, SpecialAgencyState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<SpecialAgencyState, SpecialAgencyState>,
        SpecialAgencyState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
