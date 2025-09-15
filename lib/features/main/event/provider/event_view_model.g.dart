// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EventViewModel)
const eventViewModelProvider = EventViewModelProvider._();

final class EventViewModelProvider
    extends $NotifierProvider<EventViewModel, EventState> {
  const EventViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'eventViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$eventViewModelHash();

  @$internal
  @override
  EventViewModel create() => EventViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventState>(value),
    );
  }
}

String _$eventViewModelHash() => r'dfbc07ac4d777a180ad5b44dd1d66875697be576';

abstract class _$EventViewModel extends $Notifier<EventState> {
  EventState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<EventState, EventState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<EventState, EventState>, EventState, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
