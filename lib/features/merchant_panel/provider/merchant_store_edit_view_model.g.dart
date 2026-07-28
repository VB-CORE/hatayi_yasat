// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_store_edit_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MerchantStoreEditViewModel)
final merchantStoreEditViewModelProvider = MerchantStoreEditViewModelFamily._();

final class MerchantStoreEditViewModelProvider
    extends
        $NotifierProvider<MerchantStoreEditViewModel, MerchantStoreEditState> {
  MerchantStoreEditViewModelProvider._({
    required MerchantStoreEditViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'merchantStoreEditViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$merchantStoreEditViewModelHash();

  @override
  String toString() {
    return r'merchantStoreEditViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MerchantStoreEditViewModel create() => MerchantStoreEditViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MerchantStoreEditState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MerchantStoreEditState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MerchantStoreEditViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$merchantStoreEditViewModelHash() =>
    r'9698b3e3211ec7b5c96312d63e470c04f45f686a';

final class MerchantStoreEditViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          MerchantStoreEditViewModel,
          MerchantStoreEditState,
          MerchantStoreEditState,
          MerchantStoreEditState,
          String
        > {
  MerchantStoreEditViewModelFamily._()
    : super(
        retry: null,
        name: r'merchantStoreEditViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MerchantStoreEditViewModelProvider call(String storeId) =>
      MerchantStoreEditViewModelProvider._(argument: storeId, from: this);

  @override
  String toString() => r'merchantStoreEditViewModelProvider';
}

abstract class _$MerchantStoreEditViewModel
    extends $Notifier<MerchantStoreEditState> {
  late final _$args = ref.$arg as String;
  String get storeId => _$args;

  MerchantStoreEditState build(String storeId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<MerchantStoreEditState, MerchantStoreEditState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MerchantStoreEditState, MerchantStoreEditState>,
              MerchantStoreEditState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
