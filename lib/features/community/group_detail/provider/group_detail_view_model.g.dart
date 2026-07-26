// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GroupDetailViewModel)
final groupDetailViewModelProvider = GroupDetailViewModelFamily._();

final class GroupDetailViewModelProvider
    extends $NotifierProvider<GroupDetailViewModel, GroupDetailState> {
  GroupDetailViewModelProvider._({
    required GroupDetailViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'groupDetailViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$groupDetailViewModelHash();

  @override
  String toString() {
    return r'groupDetailViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  GroupDetailViewModel create() => GroupDetailViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GroupDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GroupDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GroupDetailViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$groupDetailViewModelHash() =>
    r'eca47eaae74aa20e562f10852e93726770b18b56';

final class GroupDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          GroupDetailViewModel,
          GroupDetailState,
          GroupDetailState,
          GroupDetailState,
          String
        > {
  GroupDetailViewModelFamily._()
    : super(
        retry: null,
        name: r'groupDetailViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GroupDetailViewModelProvider call(String groupId) =>
      GroupDetailViewModelProvider._(argument: groupId, from: this);

  @override
  String toString() => r'groupDetailViewModelProvider';
}

abstract class _$GroupDetailViewModel extends $Notifier<GroupDetailState> {
  late final _$args = ref.$arg as String;
  String get groupId => _$args;

  GroupDetailState build(String groupId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<GroupDetailState, GroupDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GroupDetailState, GroupDetailState>,
              GroupDetailState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
