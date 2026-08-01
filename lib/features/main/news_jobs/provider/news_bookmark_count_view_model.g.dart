// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_bookmark_count_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NewsBookmarkCountViewModel)
final newsBookmarkCountViewModelProvider =
    NewsBookmarkCountViewModelProvider._();

final class NewsBookmarkCountViewModelProvider
    extends $NotifierProvider<NewsBookmarkCountViewModel, int> {
  NewsBookmarkCountViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'newsBookmarkCountViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$newsBookmarkCountViewModelHash();

  @$internal
  @override
  NewsBookmarkCountViewModel create() => NewsBookmarkCountViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$newsBookmarkCountViewModelHash() =>
    r'940874d79a6a471e7d423fa410cdeede49d4b6de';

abstract class _$NewsBookmarkCountViewModel extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
