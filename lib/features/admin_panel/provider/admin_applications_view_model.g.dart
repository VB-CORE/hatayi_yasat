// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_applications_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminApplicationsViewModel)
final adminApplicationsViewModelProvider =
    AdminApplicationsViewModelProvider._();

final class AdminApplicationsViewModelProvider
    extends
        $NotifierProvider<AdminApplicationsViewModel, AdminApplicationsState> {
  AdminApplicationsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminApplicationsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminApplicationsViewModelHash();

  @$internal
  @override
  AdminApplicationsViewModel create() => AdminApplicationsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminApplicationsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminApplicationsState>(value),
    );
  }
}

String _$adminApplicationsViewModelHash() =>
    r'c58604703de22ddd1132e638f5cb173704d10d39';

abstract class _$AdminApplicationsViewModel
    extends $Notifier<AdminApplicationsState> {
  AdminApplicationsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AdminApplicationsState, AdminApplicationsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdminApplicationsState, AdminApplicationsState>,
              AdminApplicationsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
