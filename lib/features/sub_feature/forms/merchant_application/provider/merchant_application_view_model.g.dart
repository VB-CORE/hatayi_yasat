// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_application_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MerchantApplicationViewModel)
final merchantApplicationViewModelProvider =
    MerchantApplicationViewModelProvider._();

final class MerchantApplicationViewModelProvider
    extends
        $NotifierProvider<
          MerchantApplicationViewModel,
          MerchantApplicationState
        > {
  MerchantApplicationViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'merchantApplicationViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$merchantApplicationViewModelHash();

  @$internal
  @override
  MerchantApplicationViewModel create() => MerchantApplicationViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MerchantApplicationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MerchantApplicationState>(value),
    );
  }
}

String _$merchantApplicationViewModelHash() =>
    r'2356b4ddca66659a9e838e25a5f346aeac66f7e1';

abstract class _$MerchantApplicationViewModel
    extends $Notifier<MerchantApplicationState> {
  MerchantApplicationState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<MerchantApplicationState, MerchantApplicationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MerchantApplicationState, MerchantApplicationState>,
              MerchantApplicationState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
