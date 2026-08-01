// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_jobs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NewsJobsProvider)
final newsJobsProviderProvider = NewsJobsProviderProvider._();

final class NewsJobsProviderProvider
    extends $NotifierProvider<NewsJobsProvider, NewsJobsState> {
  NewsJobsProviderProvider._()
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

String _$newsJobsProviderHash() => r'd5ac67bc0550ee7e21e0f5808a8b65e37d729921';

abstract class _$NewsJobsProvider extends $Notifier<NewsJobsState> {
  NewsJobsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<NewsJobsState, NewsJobsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NewsJobsState, NewsJobsState>,
              NewsJobsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
