// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_badge_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Kept alive so the app bar bell and the OS badge never disagree: the count is
/// refreshed from lifecycle and push events that outlive any single screen.

@ProviderFor(NotificationBadgeViewModel)
final notificationBadgeViewModelProvider =
    NotificationBadgeViewModelProvider._();

/// Kept alive so the app bar bell and the OS badge never disagree: the count is
/// refreshed from lifecycle and push events that outlive any single screen.
final class NotificationBadgeViewModelProvider
    extends
        $NotifierProvider<NotificationBadgeViewModel, NotificationBadgeState> {
  /// Kept alive so the app bar bell and the OS badge never disagree: the count is
  /// refreshed from lifecycle and push events that outlive any single screen.
  NotificationBadgeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationBadgeViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationBadgeViewModelHash();

  @$internal
  @override
  NotificationBadgeViewModel create() => NotificationBadgeViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationBadgeState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationBadgeState>(value),
    );
  }
}

String _$notificationBadgeViewModelHash() =>
    r'd233f7026a888fc811dab04b98755f39d49e85da';

/// Kept alive so the app bar bell and the OS badge never disagree: the count is
/// refreshed from lifecycle and push events that outlive any single screen.

abstract class _$NotificationBadgeViewModel
    extends $Notifier<NotificationBadgeState> {
  NotificationBadgeState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<NotificationBadgeState, NotificationBadgeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NotificationBadgeState, NotificationBadgeState>,
              NotificationBadgeState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
