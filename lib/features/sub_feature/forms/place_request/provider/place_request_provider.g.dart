// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_request_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PlaceRequestProvider)
const placeRequestProviderProvider = PlaceRequestProviderProvider._();

final class PlaceRequestProviderProvider
    extends $NotifierProvider<PlaceRequestProvider, PlaceRequestState> {
  const PlaceRequestProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'placeRequestProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$placeRequestProviderHash();

  @$internal
  @override
  PlaceRequestProvider create() => PlaceRequestProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlaceRequestState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlaceRequestState>(value),
    );
  }
}

String _$placeRequestProviderHash() =>
    r'75461ecbd264272713ab0728d878d0b69b002bbf';

abstract class _$PlaceRequestProvider extends $Notifier<PlaceRequestState> {
  PlaceRequestState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PlaceRequestState, PlaceRequestState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PlaceRequestState, PlaceRequestState>,
              PlaceRequestState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
