// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PlaceDetailViewModel)
final placeDetailViewModelProvider = PlaceDetailViewModelProvider._();

final class PlaceDetailViewModelProvider
    extends $NotifierProvider<PlaceDetailViewModel, PlaceDetailState> {
  PlaceDetailViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'placeDetailViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$placeDetailViewModelHash();

  @$internal
  @override
  PlaceDetailViewModel create() => PlaceDetailViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlaceDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlaceDetailState>(value),
    );
  }
}

String _$placeDetailViewModelHash() =>
    r'30ad55921ec9c4ed705765edd673c31b840cc38c';

abstract class _$PlaceDetailViewModel extends $Notifier<PlaceDetailState> {
  PlaceDetailState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PlaceDetailState, PlaceDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PlaceDetailState, PlaceDetailState>,
              PlaceDetailState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
