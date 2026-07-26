// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_discussions_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GroupDiscussionsViewModel)
final groupDiscussionsViewModelProvider = GroupDiscussionsViewModelFamily._();

final class GroupDiscussionsViewModelProvider
    extends
        $NotifierProvider<GroupDiscussionsViewModel, GroupDiscussionsState> {
  GroupDiscussionsViewModelProvider._({
    required GroupDiscussionsViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'groupDiscussionsViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$groupDiscussionsViewModelHash();

  @override
  String toString() {
    return r'groupDiscussionsViewModelProvider'
        ''
        '($argument)';
  }

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

  @override
  bool operator ==(Object other) {
    return other is GroupDiscussionsViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$groupDiscussionsViewModelHash() =>
    r'010e5c614b15a591507719de0e4c88518f0523f0';

final class GroupDiscussionsViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          GroupDiscussionsViewModel,
          GroupDiscussionsState,
          GroupDiscussionsState,
          GroupDiscussionsState,
          String
        > {
  GroupDiscussionsViewModelFamily._()
    : super(
        retry: null,
        name: r'groupDiscussionsViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GroupDiscussionsViewModelProvider call(String groupId) =>
      GroupDiscussionsViewModelProvider._(argument: groupId, from: this);

  @override
  String toString() => r'groupDiscussionsViewModelProvider';
}

abstract class _$GroupDiscussionsViewModel
    extends $Notifier<GroupDiscussionsState> {
  late final _$args = ref.$arg as String;
  String get groupId => _$args;

  GroupDiscussionsState build(String groupId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<GroupDiscussionsState, GroupDiscussionsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GroupDiscussionsState, GroupDiscussionsState>,
              GroupDiscussionsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
