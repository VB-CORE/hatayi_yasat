// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_group_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateGroupViewModel)
final createGroupViewModelProvider = CreateGroupViewModelProvider._();

final class CreateGroupViewModelProvider
    extends $NotifierProvider<CreateGroupViewModel, CreateGroupState> {
  CreateGroupViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createGroupViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createGroupViewModelHash();

  @$internal
  @override
  CreateGroupViewModel create() => CreateGroupViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateGroupState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateGroupState>(value),
    );
  }
}

String _$createGroupViewModelHash() =>
    r'4adb019dd3b66fedce628196d7413824408e3135';

abstract class _$CreateGroupViewModel extends $Notifier<CreateGroupState> {
  CreateGroupState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CreateGroupState, CreateGroupState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CreateGroupState, CreateGroupState>,
              CreateGroupState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
