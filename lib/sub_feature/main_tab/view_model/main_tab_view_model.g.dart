// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_tab_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(MainTabViewModel)
const mainTabViewModelProvider = MainTabViewModelProvider._();

final class MainTabViewModelProvider
    extends $NotifierProvider<MainTabViewModel, MainTabState> {
  const MainTabViewModelProvider._()
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
    final created = build();
    final ref = this.ref as $Ref<MainTabState, MainTabState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MainTabState, MainTabState>,
              MainTabState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
