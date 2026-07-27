// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monetization_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MonetizationViewModel)
final monetizationViewModelProvider = MonetizationViewModelProvider._();

final class MonetizationViewModelProvider
    extends $NotifierProvider<MonetizationViewModel, MonetizationState> {
  MonetizationViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'monetizationViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$monetizationViewModelHash();

  @$internal
  @override
  MonetizationViewModel create() => MonetizationViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MonetizationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MonetizationState>(value),
    );
  }
}

String _$monetizationViewModelHash() =>
    r'7d307c427d97140097dbd5bdfc2e4199fa8c7dc9';

abstract class _$MonetizationViewModel extends $Notifier<MonetizationState> {
  MonetizationState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MonetizationState, MonetizationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MonetizationState, MonetizationState>,
              MonetizationState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
