// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_tab_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MainTabViewModel)
final mainTabViewModelProvider = MainTabViewModelProvider._();

final class MainTabViewModelProvider
    extends $NotifierProvider<MainTabViewModel, MainTabState> {
  MainTabViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mainTabViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mainTabViewModelHash();

  @$internal
  @override
  MainTabViewModel create() => MainTabViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MainTabState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MainTabState>(value),
    );
  }
}

String _$mainTabViewModelHash() => r'11d29aa45f02e8a78226a88e49b4ddcd12cc1b9d';

abstract class _$MainTabViewModel extends $Notifier<MainTabState> {
  MainTabState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MainTabState, MainTabState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MainTabState, MainTabState>,
              MainTabState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
