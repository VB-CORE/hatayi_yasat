// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_bookmark_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NewsBookmarkViewModel)
final newsBookmarkViewModelProvider = NewsBookmarkViewModelFamily._();

final class NewsBookmarkViewModelProvider
    extends $NotifierProvider<NewsBookmarkViewModel, NewsBookmarkState> {
  NewsBookmarkViewModelProvider._({
    required NewsBookmarkViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'newsBookmarkViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$newsBookmarkViewModelHash();

  @override
  String toString() {
    return r'newsBookmarkViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  NewsBookmarkViewModel create() => NewsBookmarkViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NewsBookmarkState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NewsBookmarkState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is NewsBookmarkViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$newsBookmarkViewModelHash() =>
    r'c52a731d45574db5a6c7bf35327236ef63511786';

final class NewsBookmarkViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          NewsBookmarkViewModel,
          NewsBookmarkState,
          NewsBookmarkState,
          NewsBookmarkState,
          String
        > {
  NewsBookmarkViewModelFamily._()
    : super(
        retry: null,
        name: r'newsBookmarkViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  NewsBookmarkViewModelProvider call(String newsId) =>
      NewsBookmarkViewModelProvider._(argument: newsId, from: this);

  @override
  String toString() => r'newsBookmarkViewModelProvider';
}

abstract class _$NewsBookmarkViewModel extends $Notifier<NewsBookmarkState> {
  late final _$args = ref.$arg as String;
  String get newsId => _$args;

  NewsBookmarkState build(String newsId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<NewsBookmarkState, NewsBookmarkState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NewsBookmarkState, NewsBookmarkState>,
              NewsBookmarkState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
