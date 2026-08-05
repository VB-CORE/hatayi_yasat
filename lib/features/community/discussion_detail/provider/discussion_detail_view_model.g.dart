// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discussion_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DiscussionDetailViewModel)
final discussionDetailViewModelProvider = DiscussionDetailViewModelFamily._();

final class DiscussionDetailViewModelProvider
    extends
        $NotifierProvider<DiscussionDetailViewModel, DiscussionDetailState> {
  DiscussionDetailViewModelProvider._({
    required DiscussionDetailViewModelFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'discussionDetailViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$discussionDetailViewModelHash();

  @override
  String toString() {
    return r'discussionDetailViewModelProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  DiscussionDetailViewModel create() => DiscussionDetailViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DiscussionDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DiscussionDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DiscussionDetailViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$discussionDetailViewModelHash() =>
    r'86d564ca9033cca4eba54f58c140bf3e7595f3a7';

final class DiscussionDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          DiscussionDetailViewModel,
          DiscussionDetailState,
          DiscussionDetailState,
          DiscussionDetailState,
          (String, String)
        > {
  DiscussionDetailViewModelFamily._()
    : super(
        retry: null,
        name: r'discussionDetailViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DiscussionDetailViewModelProvider call(String groupId, String discussionId) =>
      DiscussionDetailViewModelProvider._(
        argument: (groupId, discussionId),
        from: this,
      );

  @override
  String toString() => r'discussionDetailViewModelProvider';
}

abstract class _$DiscussionDetailViewModel
    extends $Notifier<DiscussionDetailState> {
  late final _$args = ref.$arg as (String, String);
  String get groupId => _$args.$1;
  String get discussionId => _$args.$2;

  DiscussionDetailState build(String groupId, String discussionId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DiscussionDetailState, DiscussionDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DiscussionDetailState, DiscussionDetailState>,
              DiscussionDetailState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
