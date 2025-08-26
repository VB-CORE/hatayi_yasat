// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chain_store_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ChainStoreProvider)
const chainStoreProviderProvider = ChainStoreProviderProvider._();

final class ChainStoreProviderProvider
    extends $NotifierProvider<ChainStoreProvider, ChainStoreState> {
  const ChainStoreProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chainStoreProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chainStoreProviderHash();

  @$internal
  @override
  ChainStoreProvider create() => ChainStoreProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChainStoreState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChainStoreState>(value),
    );
  }
}

String _$chainStoreProviderHash() =>
    r'41e52a50d0f5a57c68a677a182884514002805cf';

abstract class _$ChainStoreProvider extends $Notifier<ChainStoreState> {
  ChainStoreState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ChainStoreState, ChainStoreState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ChainStoreState, ChainStoreState>,
              ChainStoreState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
