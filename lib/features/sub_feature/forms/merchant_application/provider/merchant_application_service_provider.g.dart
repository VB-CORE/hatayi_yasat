// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_application_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(merchantApplicationService)
final merchantApplicationServiceProvider =
    MerchantApplicationServiceProvider._();

final class MerchantApplicationServiceProvider
    extends
        $FunctionalProvider<
          MerchantApplicationService,
          MerchantApplicationService,
          MerchantApplicationService
        >
    with $Provider<MerchantApplicationService> {
  MerchantApplicationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'merchantApplicationServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$merchantApplicationServiceHash();

  @$internal
  @override
  $ProviderElement<MerchantApplicationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MerchantApplicationService create(Ref ref) {
    return merchantApplicationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MerchantApplicationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MerchantApplicationService>(value),
    );
  }
}

String _$merchantApplicationServiceHash() =>
    r'905365fdfa535345a55aac7c3a1cd43552b9dcb0';
