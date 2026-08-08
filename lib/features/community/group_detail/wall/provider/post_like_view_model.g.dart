// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_like_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PostLikeViewModel)
final postLikeViewModelProvider = PostLikeViewModelFamily._();

final class PostLikeViewModelProvider
    extends $NotifierProvider<PostLikeViewModel, PostLikeState> {
  PostLikeViewModelProvider._({
    required PostLikeViewModelFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'postLikeViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$postLikeViewModelHash();

  @override
  String toString() {
    return r'postLikeViewModelProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  PostLikeViewModel create() => PostLikeViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostLikeState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostLikeState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PostLikeViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$postLikeViewModelHash() => r'59dfff3e2938f24c84561837899ef04483ac8d9e';

final class PostLikeViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          PostLikeViewModel,
          PostLikeState,
          PostLikeState,
          PostLikeState,
          (String, String)
        > {
  PostLikeViewModelFamily._()
    : super(
        retry: null,
        name: r'postLikeViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PostLikeViewModelProvider call(String groupId, String postId) =>
      PostLikeViewModelProvider._(argument: (groupId, postId), from: this);

  @override
  String toString() => r'postLikeViewModelProvider';
}

abstract class _$PostLikeViewModel extends $Notifier<PostLikeState> {
  late final _$args = ref.$arg as (String, String);
  String get groupId => _$args.$1;
  String get postId => _$args.$2;

  PostLikeState build(String groupId, String postId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PostLikeState, PostLikeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PostLikeState, PostLikeState>,
              PostLikeState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
