// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_tab_jump_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MainTabJumpNotifier)
final mainTabJumpProvider = MainTabJumpNotifierProvider._();

final class MainTabJumpNotifierProvider
    extends $NotifierProvider<MainTabJumpNotifier, int?> {
  MainTabJumpNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mainTabJumpProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mainTabJumpNotifierHash();

  @$internal
  @override
  MainTabJumpNotifier create() => MainTabJumpNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$mainTabJumpNotifierHash() =>
    r'69919bf416a18054907c2382a7a88d3cee510d72';

abstract class _$MainTabJumpNotifier extends $Notifier<int?> {
  int? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
