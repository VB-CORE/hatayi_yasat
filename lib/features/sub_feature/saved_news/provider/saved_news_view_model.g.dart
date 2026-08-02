// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_news_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SavedNewsViewModel)
final savedNewsViewModelProvider = SavedNewsViewModelProvider._();

final class SavedNewsViewModelProvider
    extends $NotifierProvider<SavedNewsViewModel, SavedNewsState> {
  SavedNewsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedNewsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedNewsViewModelHash();

  @$internal
  @override
  SavedNewsViewModel create() => SavedNewsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SavedNewsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SavedNewsState>(value),
    );
  }
}

String _$savedNewsViewModelHash() =>
    r'44c1b24e43a0bc4bb4a1d9af3d7d514909acc8dc';

abstract class _$SavedNewsViewModel extends $Notifier<SavedNewsState> {
  SavedNewsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SavedNewsState, SavedNewsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SavedNewsState, SavedNewsState>,
              SavedNewsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
