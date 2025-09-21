// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavoriteViewModel)
const favoriteViewModelProvider = FavoriteViewModelProvider._();

final class FavoriteViewModelProvider
    extends $NotifierProvider<FavoriteViewModel, FavoriteState> {
  const FavoriteViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'favoriteViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$favoriteViewModelHash();

  @$internal
  @override
  FavoriteViewModel create() => FavoriteViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavoriteState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavoriteState>(value),
    );
  }
}

String _$favoriteViewModelHash() => r'057dcbe3d95a8f73c880d57eea07146941af1902';

abstract class _$FavoriteViewModel extends $Notifier<FavoriteState> {
  FavoriteState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FavoriteState, FavoriteState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<FavoriteState, FavoriteState>,
        FavoriteState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
