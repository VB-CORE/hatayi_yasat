// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(EventDetailProvider)
const eventDetailProviderProvider = EventDetailProviderProvider._();

final class EventDetailProviderProvider
    extends $NotifierProvider<EventDetailProvider, EventDetailState> {
  const EventDetailProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventDetailProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventDetailProviderHash();

  @$internal
  @override
  EventDetailProvider create() => EventDetailProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventDetailState>(value),
    );
  }
}

String _$eventDetailProviderHash() =>
    r'0ac19d9ab456519384b11f6ec0a5a82fd2182ce6';

abstract class _$EventDetailProvider extends $Notifier<EventDetailState> {
  EventDetailState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<EventDetailState, EventDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EventDetailState, EventDetailState>,
              EventDetailState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
