// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationsViewModel)
final notificationsViewModelProvider = NotificationsViewModelProvider._();

final class NotificationsViewModelProvider
    extends $NotifierProvider<NotificationsViewModel, NotificationsState> {
  NotificationsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsViewModelHash();

  @$internal
  @override
  NotificationsViewModel create() => NotificationsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationsState>(value),
    );
  }
}

String _$notificationsViewModelHash() =>
    r'861a52cdd0af577fc1315a58730f1e52972fbb78';

abstract class _$NotificationsViewModel extends $Notifier<NotificationsState> {
  NotificationsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<NotificationsState, NotificationsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NotificationsState, NotificationsState>,
              NotificationsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
