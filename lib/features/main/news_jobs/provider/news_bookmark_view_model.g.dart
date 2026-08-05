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
    r'4e442ad831f7ab4258d85a33a62cdaaf04fc0a19';

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
  void runBuild() {
    final ref = this.ref as $Ref<NewsBookmarkState, NewsBookmarkState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NewsBookmarkState, NewsBookmarkState>,
              NewsBookmarkState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(newsBookmarkCount)
final newsBookmarkCountProvider = NewsBookmarkCountProvider._();

final class NewsBookmarkCountProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  NewsBookmarkCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'newsBookmarkCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$newsBookmarkCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return newsBookmarkCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$newsBookmarkCountHash() => r'd0734a1efd90706fd61a0e1fa43a71b590b695a2';
