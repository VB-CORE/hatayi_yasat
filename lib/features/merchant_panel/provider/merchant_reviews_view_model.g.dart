// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_reviews_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MerchantReviewsViewModel)
final merchantReviewsViewModelProvider = MerchantReviewsViewModelFamily._();

final class MerchantReviewsViewModelProvider
    extends $NotifierProvider<MerchantReviewsViewModel, MerchantReviewsState> {
  MerchantReviewsViewModelProvider._({
    required MerchantReviewsViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'merchantReviewsViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$merchantReviewsViewModelHash();

  @override
  String toString() {
    return r'merchantReviewsViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MerchantReviewsViewModel create() => MerchantReviewsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MerchantReviewsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MerchantReviewsState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MerchantReviewsViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$merchantReviewsViewModelHash() =>
    r'5a895e51bb891cd23a8bc8f5acb1d1e8182a17fd';

final class MerchantReviewsViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          MerchantReviewsViewModel,
          MerchantReviewsState,
          MerchantReviewsState,
          MerchantReviewsState,
          String
        > {
  MerchantReviewsViewModelFamily._()
    : super(
        retry: null,
        name: r'merchantReviewsViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MerchantReviewsViewModelProvider call(String storeId) =>
      MerchantReviewsViewModelProvider._(argument: storeId, from: this);

  @override
  String toString() => r'merchantReviewsViewModelProvider';
}

abstract class _$MerchantReviewsViewModel
    extends $Notifier<MerchantReviewsState> {
  late final _$args = ref.$arg as String;
  String get storeId => _$args;

  MerchantReviewsState build(String storeId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MerchantReviewsState, MerchantReviewsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MerchantReviewsState, MerchantReviewsState>,
              MerchantReviewsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
