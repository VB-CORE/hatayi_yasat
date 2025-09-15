// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_jobs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NewsJobsProvider)
const newsJobsProviderProvider = NewsJobsProviderProvider._();

final class NewsJobsProviderProvider
    extends $NotifierProvider<NewsJobsProvider, NewsJobsState> {
  const NewsJobsProviderProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'newsJobsProviderProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$newsJobsProviderHash();

  @$internal
  @override
  NewsJobsProvider create() => NewsJobsProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NewsJobsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NewsJobsState>(value),
    );
  }
}

String _$newsJobsProviderHash() => r'0f49d5e776db28097b081abd3dfb047282723115';

abstract class _$NewsJobsProvider extends $Notifier<NewsJobsState> {
  NewsJobsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<NewsJobsState, NewsJobsState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<NewsJobsState, NewsJobsState>,
        NewsJobsState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
