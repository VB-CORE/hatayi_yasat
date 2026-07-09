// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_wall_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GroupWallViewModel)
final groupWallViewModelProvider = GroupWallViewModelProvider._();

final class GroupWallViewModelProvider
    extends $NotifierProvider<GroupWallViewModel, GroupWallState> {
  GroupWallViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'groupWallViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$groupWallViewModelHash();

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
}

String _$groupWallViewModelHash() =>
    r'7b745714c605ac7e40b489788820a820f3d52767';

abstract class _$GroupWallViewModel extends $Notifier<GroupWallState> {
  GroupWallState build();
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
    return element.handleCreate(ref, build);
  }
}
