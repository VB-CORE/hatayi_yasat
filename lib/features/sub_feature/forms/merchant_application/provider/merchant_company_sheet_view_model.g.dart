// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_company_sheet_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MerchantCompanySheetViewModel)
final merchantCompanySheetViewModelProvider =
    MerchantCompanySheetViewModelProvider._();

final class MerchantCompanySheetViewModelProvider
    extends
        $NotifierProvider<
          MerchantCompanySheetViewModel,
          MerchantCompanySheetState
        > {
  MerchantCompanySheetViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'merchantCompanySheetViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$merchantCompanySheetViewModelHash();

  @$internal
  @override
  MerchantCompanySheetViewModel create() => MerchantCompanySheetViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MerchantCompanySheetState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MerchantCompanySheetState>(value),
    );
  }
}

String _$merchantCompanySheetViewModelHash() =>
    r'730f01705bd37d389b7bcc56785bbf8da3cef804';

abstract class _$MerchantCompanySheetViewModel
    extends $Notifier<MerchantCompanySheetState> {
  MerchantCompanySheetState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<MerchantCompanySheetState, MerchantCompanySheetState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MerchantCompanySheetState, MerchantCompanySheetState>,
              MerchantCompanySheetState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
