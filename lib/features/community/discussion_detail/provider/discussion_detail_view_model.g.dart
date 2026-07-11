// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discussion_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DiscussionDetailViewModel)
final discussionDetailViewModelProvider = DiscussionDetailViewModelProvider._();

final class DiscussionDetailViewModelProvider
    extends
        $NotifierProvider<DiscussionDetailViewModel, DiscussionDetailState> {
  DiscussionDetailViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discussionDetailViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discussionDetailViewModelHash();

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
}

String _$discussionDetailViewModelHash() =>
    r'f9e7c6a7fa8766f6db4517c7d4ac7ebc148852aa';

abstract class _$DiscussionDetailViewModel
    extends $Notifier<DiscussionDetailState> {
  DiscussionDetailState build();
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
    return element.handleCreate(ref, build);
  }
}
