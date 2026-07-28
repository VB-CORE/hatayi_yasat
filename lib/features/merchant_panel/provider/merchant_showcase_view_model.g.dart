// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_showcase_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MerchantShowcaseViewModel)
final merchantShowcaseViewModelProvider = MerchantShowcaseViewModelFamily._();

final class MerchantShowcaseViewModelProvider
    extends
        $NotifierProvider<MerchantShowcaseViewModel, MerchantShowcaseState> {
  MerchantShowcaseViewModelProvider._({
    required MerchantShowcaseViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'merchantShowcaseViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$merchantShowcaseViewModelHash();

  @override
  String toString() {
    return r'merchantShowcaseViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MerchantShowcaseViewModel create() => MerchantShowcaseViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MerchantShowcaseState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MerchantShowcaseState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MerchantShowcaseViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$merchantShowcaseViewModelHash() =>
    r'37ce314b6834c9e9077316b3b2a8666574412f57';

final class MerchantShowcaseViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          MerchantShowcaseViewModel,
          MerchantShowcaseState,
          MerchantShowcaseState,
          MerchantShowcaseState,
          String
        > {
  MerchantShowcaseViewModelFamily._()
    : super(
        retry: null,
        name: r'merchantShowcaseViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MerchantShowcaseViewModelProvider call(String storeId) =>
      MerchantShowcaseViewModelProvider._(argument: storeId, from: this);

  @override
  String toString() => r'merchantShowcaseViewModelProvider';
}

abstract class _$MerchantShowcaseViewModel
    extends $Notifier<MerchantShowcaseState> {
  late final _$args = ref.$arg as String;
  String get storeId => _$args;

  MerchantShowcaseState build(String storeId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MerchantShowcaseState, MerchantShowcaseState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MerchantShowcaseState, MerchantShowcaseState>,
              MerchantShowcaseState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
