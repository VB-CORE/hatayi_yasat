// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mockUser)
final mockUserProvider = MockUserFamily._();

final class MockUserProvider
    extends $FunctionalProvider<MockUserModel, MockUserModel, MockUserModel>
    with $Provider<MockUserModel> {
  MockUserProvider._({
    required MockUserFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'mockUserProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mockUserHash();

  @override
  String toString() {
    return r'mockUserProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<MockUserModel> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MockUserModel create(Ref ref) {
    final argument = this.argument as String;
    return mockUser(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MockUserModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MockUserModel>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MockUserProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mockUserHash() => r'476ec3656cd4cc3378b875cb27d809d70a7a7c9f';

final class MockUserFamily extends $Family
    with $FunctionalFamilyOverride<MockUserModel, String> {
  MockUserFamily._()
    : super(
        retry: null,
        name: r'mockUserProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MockUserProvider call(String userId) =>
      MockUserProvider._(argument: userId, from: this);

  @override
  String toString() => r'mockUserProvider';
}
