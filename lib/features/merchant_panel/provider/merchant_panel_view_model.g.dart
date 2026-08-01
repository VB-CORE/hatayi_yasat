// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_panel_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MerchantPanelViewModel)
final merchantPanelViewModelProvider = MerchantPanelViewModelProvider._();

final class MerchantPanelViewModelProvider
    extends $NotifierProvider<MerchantPanelViewModel, MerchantPanelState> {
  MerchantPanelViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'merchantPanelViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$merchantPanelViewModelHash();

  @$internal
  @override
  MerchantPanelViewModel create() => MerchantPanelViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MerchantPanelState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MerchantPanelState>(value),
    );
  }
}

String _$merchantPanelViewModelHash() =>
    r'3749b2bfd906f4dc1a56008d7f4d5c232cda2b90';

abstract class _$MerchantPanelViewModel extends $Notifier<MerchantPanelState> {
  MerchantPanelState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MerchantPanelState, MerchantPanelState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MerchantPanelState, MerchantPanelState>,
              MerchantPanelState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
