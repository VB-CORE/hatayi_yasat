// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_users_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminUsersViewModel)
final adminUsersViewModelProvider = AdminUsersViewModelProvider._();

final class AdminUsersViewModelProvider
    extends $NotifierProvider<AdminUsersViewModel, AdminUsersState> {
  AdminUsersViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminUsersViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminUsersViewModelHash();

  @$internal
  @override
  AdminUsersViewModel create() => AdminUsersViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminUsersState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminUsersState>(value),
    );
  }
}

String _$adminUsersViewModelHash() =>
    r'ced8968cf5f30f193de47b70d141bef39cdd6797';

abstract class _$AdminUsersViewModel extends $Notifier<AdminUsersState> {
  AdminUsersState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AdminUsersState, AdminUsersState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdminUsersState, AdminUsersState>,
              AdminUsersState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
