// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_community_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rateCommunityService)
final rateCommunityServiceProvider = RateCommunityServiceProvider._();

final class RateCommunityServiceProvider
    extends
        $FunctionalProvider<
          RateCommunityService,
          RateCommunityService,
          RateCommunityService
        >
    with $Provider<RateCommunityService> {
  RateCommunityServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rateCommunityServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rateCommunityServiceHash();

  @$internal
  @override
  $ProviderElement<RateCommunityService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RateCommunityService create(Ref ref) {
    return rateCommunityService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RateCommunityService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RateCommunityService>(value),
    );
  }
}

String _$rateCommunityServiceHash() =>
    r'37609161a39b1757e98928a8dda8bb97f1bb964d';
