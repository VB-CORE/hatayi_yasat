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
    r'9b87bac4d238e90bc16f41fdd6f4179b213c5937';

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
