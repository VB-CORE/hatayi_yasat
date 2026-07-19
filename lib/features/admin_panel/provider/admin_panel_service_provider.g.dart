// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_panel_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminPanelService)
final adminPanelServiceProvider = AdminPanelServiceProvider._();

final class AdminPanelServiceProvider
    extends
        $FunctionalProvider<
          AdminPanelService,
          AdminPanelService,
          AdminPanelService
        >
    with $Provider<AdminPanelService> {
  AdminPanelServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminPanelServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminPanelServiceHash();

  @$internal
  @override
  $ProviderElement<AdminPanelService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdminPanelService create(Ref ref) {
    return adminPanelService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminPanelService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminPanelService>(value),
    );
  }
}

String _$adminPanelServiceHash() => r'a001c8b6c0e4b21557df5056305bc43ced2ef278';
