// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GroupsViewModel)
final groupsViewModelProvider = GroupsViewModelProvider._();

final class GroupsViewModelProvider
    extends $NotifierProvider<GroupsViewModel, GroupsState> {
  GroupsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'groupsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$groupsViewModelHash();

  @$internal
  @override
  GroupsViewModel create() => GroupsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GroupsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GroupsState>(value),
    );
  }
}

String _$groupsViewModelHash() => r'b5fda6b048fd4d199ff39eb44c48e91e1ee7009a';

abstract class _$GroupsViewModel extends $Notifier<GroupsState> {
  GroupsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<GroupsState, GroupsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GroupsState, GroupsState>,
              GroupsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
