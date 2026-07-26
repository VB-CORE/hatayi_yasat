// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_members_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GroupMembersViewModel)
final groupMembersViewModelProvider = GroupMembersViewModelFamily._();

final class GroupMembersViewModelProvider
    extends $NotifierProvider<GroupMembersViewModel, GroupMembersState> {
  GroupMembersViewModelProvider._({
    required GroupMembersViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'groupMembersViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$groupMembersViewModelHash();

  @override
  String toString() {
    return r'groupMembersViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  GroupMembersViewModel create() => GroupMembersViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GroupMembersState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GroupMembersState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GroupMembersViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$groupMembersViewModelHash() =>
    r'33a8adbc83ad531f05ba56179f3c469b4daf0828';

final class GroupMembersViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          GroupMembersViewModel,
          GroupMembersState,
          GroupMembersState,
          GroupMembersState,
          String
        > {
  GroupMembersViewModelFamily._()
    : super(
        retry: null,
        name: r'groupMembersViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GroupMembersViewModelProvider call(String groupId) =>
      GroupMembersViewModelProvider._(argument: groupId, from: this);

  @override
  String toString() => r'groupMembersViewModelProvider';
}

abstract class _$GroupMembersViewModel extends $Notifier<GroupMembersState> {
  late final _$args = ref.$arg as String;
  String get groupId => _$args;

  GroupMembersState build(String groupId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<GroupMembersState, GroupMembersState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GroupMembersState, GroupMembersState>,
              GroupMembersState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
