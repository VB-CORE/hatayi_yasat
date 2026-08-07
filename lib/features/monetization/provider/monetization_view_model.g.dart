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
    r'f7dc055cc8b5a857c49bba0325b5bc49d352bd36';

abstract class _$MonetizationViewModel extends $Notifier<MonetizationState> {
  MonetizationState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MonetizationState, MonetizationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MonetizationState, MonetizationState>,
              MonetizationState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
