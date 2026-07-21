// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PlaceDetailViewModel)
final placeDetailViewModelProvider = PlaceDetailViewModelFamily._();

final class PlaceDetailViewModelProvider
    extends $NotifierProvider<PlaceDetailViewModel, PlaceDetailState> {
  PlaceDetailViewModelProvider._({
    required PlaceDetailViewModelFamily super.from,
    required PlaceDetailArgs super.argument,
  }) : super(
         retry: null,
         name: r'placeDetailViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$placeDetailViewModelHash();

  @override
  String toString() {
    return r'placeDetailViewModelProvider'
        ''
        '($argument)';
  }

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

  @override
  bool operator ==(Object other) {
    return other is PlaceDetailViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$placeDetailViewModelHash() =>
    r'13121995cba6246c03f2d8a3b52c69e0f687b54f';

final class PlaceDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          PlaceDetailViewModel,
          PlaceDetailState,
          PlaceDetailState,
          PlaceDetailState,
          PlaceDetailArgs
        > {
  PlaceDetailViewModelFamily._()
    : super(
        retry: null,
        name: r'placeDetailViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PlaceDetailViewModelProvider call(PlaceDetailArgs args) =>
      PlaceDetailViewModelProvider._(argument: args, from: this);

  @override
  String toString() => r'placeDetailViewModelProvider';
}

abstract class _$PlaceDetailViewModel extends $Notifier<PlaceDetailState> {
  late final _$args = ref.$arg as PlaceDetailArgs;
  PlaceDetailArgs get args => _$args;

  PlaceDetailState build(PlaceDetailArgs args);
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
    element.handleCreate(ref, () => build(_$args));
  }
}
