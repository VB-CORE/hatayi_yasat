// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Owns the list screen, including the membership check and join that happen
/// on a tap. `GroupMembersViewModel` is scoped to the detail screen, so it is
/// not alive yet at that point — both go through [GroupMembershipMixin].

@ProviderFor(GroupsViewModel)
final groupsViewModelProvider = GroupsViewModelProvider._();

/// Owns the list screen, including the membership check and join that happen
/// on a tap. `GroupMembersViewModel` is scoped to the detail screen, so it is
/// not alive yet at that point — both go through [GroupMembershipMixin].
final class GroupsViewModelProvider
    extends $NotifierProvider<GroupsViewModel, GroupsState> {
  /// Owns the list screen, including the membership check and join that happen
  /// on a tap. `GroupMembersViewModel` is scoped to the detail screen, so it is
  /// not alive yet at that point — both go through [GroupMembershipMixin].
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

/// Owns the list screen, including the membership check and join that happen
/// on a tap. `GroupMembersViewModel` is scoped to the detail screen, so it is
/// not alive yet at that point — both go through [GroupMembershipMixin].

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
