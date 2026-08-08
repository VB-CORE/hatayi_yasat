// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_badge_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationBadgeViewModel)
final notificationBadgeViewModelProvider =
    NotificationBadgeViewModelProvider._();

final class NotificationBadgeViewModelProvider
    extends
        $NotifierProvider<NotificationBadgeViewModel, NotificationBadgeState> {
  NotificationBadgeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationBadgeViewModelProvider',
        isAutoDispose: true,
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
    r'648becc194867a11f2947a1d9d25bb2f3c8ff155';

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
