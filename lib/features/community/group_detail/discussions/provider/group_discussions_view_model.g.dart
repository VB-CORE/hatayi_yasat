// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_discussions_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GroupDiscussionsViewModel)
final groupDiscussionsViewModelProvider = GroupDiscussionsViewModelProvider._();

final class GroupDiscussionsViewModelProvider
    extends
        $NotifierProvider<GroupDiscussionsViewModel, GroupDiscussionsState> {
  GroupDiscussionsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'groupDiscussionsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$groupDiscussionsViewModelHash();

  @$internal
  @override
  GroupDiscussionsViewModel create() => GroupDiscussionsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GroupDiscussionsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GroupDiscussionsState>(value),
    );
  }
}

String _$groupDiscussionsViewModelHash() =>
    r'e5e9d433180883719c338a1a698bb6fd4ad5e368';

abstract class _$GroupDiscussionsViewModel
    extends $Notifier<GroupDiscussionsState> {
  GroupDiscussionsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<GroupDiscussionsState, GroupDiscussionsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GroupDiscussionsState, GroupDiscussionsState>,
              GroupDiscussionsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
