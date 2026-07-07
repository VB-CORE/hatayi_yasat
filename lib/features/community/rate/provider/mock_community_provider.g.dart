// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_community_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mockCommunity)
final mockCommunityProvider = MockCommunityFamily._();

final class MockCommunityProvider
    extends
        $FunctionalProvider<
          MockCommunityModel,
          MockCommunityModel,
          MockCommunityModel
        >
    with $Provider<MockCommunityModel> {
  MockCommunityProvider._({
    required MockCommunityFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'mockCommunityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mockCommunityHash();

  @override
  String toString() {
    return r'mockCommunityProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<MockCommunityModel> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MockCommunityModel create(Ref ref) {
    final argument = this.argument as String;
    return mockCommunity(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MockCommunityModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MockCommunityModel>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MockCommunityProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mockCommunityHash() => r'41aa5771e2e0ba41e5f79cf318a20d30404c6108';

final class MockCommunityFamily extends $Family
    with $FunctionalFamilyOverride<MockCommunityModel, String> {
  MockCommunityFamily._()
    : super(
        retry: null,
        name: r'mockCommunityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MockCommunityProvider call(String esnafId) =>
      MockCommunityProvider._(argument: esnafId, from: this);

  @override
  String toString() => r'mockCommunityProvider';
}
