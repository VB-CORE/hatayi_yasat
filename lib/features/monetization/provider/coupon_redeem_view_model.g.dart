// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_redeem_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CouponRedeemViewModel)
final couponRedeemViewModelProvider = CouponRedeemViewModelFamily._();

final class CouponRedeemViewModelProvider
    extends $NotifierProvider<CouponRedeemViewModel, CouponRedeemState> {
  CouponRedeemViewModelProvider._({
    required CouponRedeemViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'couponRedeemViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$couponRedeemViewModelHash();

  @override
  String toString() {
    return r'couponRedeemViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CouponRedeemViewModel create() => CouponRedeemViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CouponRedeemState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CouponRedeemState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CouponRedeemViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$couponRedeemViewModelHash() =>
    r'c056c3c15543376ab872d98e102e8dfa922813d6';

final class CouponRedeemViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          CouponRedeemViewModel,
          CouponRedeemState,
          CouponRedeemState,
          CouponRedeemState,
          String
        > {
  CouponRedeemViewModelFamily._()
    : super(
        retry: null,
        name: r'couponRedeemViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CouponRedeemViewModelProvider call(String couponId) =>
      CouponRedeemViewModelProvider._(argument: couponId, from: this);

  @override
  String toString() => r'couponRedeemViewModelProvider';
}

abstract class _$CouponRedeemViewModel extends $Notifier<CouponRedeemState> {
  late final _$args = ref.$arg as String;
  String get couponId => _$args;

  CouponRedeemState build(String couponId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CouponRedeemState, CouponRedeemState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CouponRedeemState, CouponRedeemState>,
              CouponRedeemState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
