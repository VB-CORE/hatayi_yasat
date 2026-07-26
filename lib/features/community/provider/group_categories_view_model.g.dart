// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_categories_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GroupCategoriesViewModel)
final groupCategoriesViewModelProvider = GroupCategoriesViewModelProvider._();

final class GroupCategoriesViewModelProvider
    extends $NotifierProvider<GroupCategoriesViewModel, GroupCategoriesState> {
  GroupCategoriesViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'groupCategoriesViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$groupCategoriesViewModelHash();

  @$internal
  @override
  GroupCategoriesViewModel create() => GroupCategoriesViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GroupCategoriesState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GroupCategoriesState>(value),
    );
  }
}

String _$groupCategoriesViewModelHash() =>
    r'e09e8e851bf1c9b68aa22efc3530345b867ebfc5';

abstract class _$GroupCategoriesViewModel
    extends $Notifier<GroupCategoriesState> {
  GroupCategoriesState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<GroupCategoriesState, GroupCategoriesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GroupCategoriesState, GroupCategoriesState>,
              GroupCategoriesState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
