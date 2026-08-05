// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_wall_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GroupWallViewModel)
final groupWallViewModelProvider = GroupWallViewModelFamily._();

final class GroupWallViewModelProvider
    extends $NotifierProvider<GroupWallViewModel, GroupWallState> {
  GroupWallViewModelProvider._({
    required GroupWallViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'groupWallViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$groupWallViewModelHash();

  @override
  String toString() {
    return r'groupWallViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  GroupWallViewModel create() => GroupWallViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GroupWallState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GroupWallState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GroupWallViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$groupWallViewModelHash() =>
    r'da7980a0b3a5d61bda781cfd106d8fc556becfb5';

final class GroupWallViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          GroupWallViewModel,
          GroupWallState,
          GroupWallState,
          GroupWallState,
          String
        > {
  GroupWallViewModelFamily._()
    : super(
        retry: null,
        name: r'groupWallViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GroupWallViewModelProvider call(String groupId) =>
      GroupWallViewModelProvider._(argument: groupId, from: this);

  @override
  String toString() => r'groupWallViewModelProvider';
}

abstract class _$GroupWallViewModel extends $Notifier<GroupWallState> {
  late final _$args = ref.$arg as String;
  String get groupId => _$args;

  GroupWallState build(String groupId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<GroupWallState, GroupWallState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GroupWallState, GroupWallState>,
              GroupWallState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
