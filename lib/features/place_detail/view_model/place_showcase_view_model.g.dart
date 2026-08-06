// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_showcase_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PlaceShowcaseViewModel)
final placeShowcaseViewModelProvider = PlaceShowcaseViewModelFamily._();

final class PlaceShowcaseViewModelProvider
    extends $NotifierProvider<PlaceShowcaseViewModel, PlaceShowcaseState> {
  PlaceShowcaseViewModelProvider._({
    required PlaceShowcaseViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'placeShowcaseViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$placeShowcaseViewModelHash();

  @override
  String toString() {
    return r'placeShowcaseViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PlaceShowcaseViewModel create() => PlaceShowcaseViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlaceShowcaseState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlaceShowcaseState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PlaceShowcaseViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$placeShowcaseViewModelHash() =>
    r'78c97fba4b4423d7e05f2080be2be733f0344393';

final class PlaceShowcaseViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          PlaceShowcaseViewModel,
          PlaceShowcaseState,
          PlaceShowcaseState,
          PlaceShowcaseState,
          String
        > {
  PlaceShowcaseViewModelFamily._()
    : super(
        retry: null,
        name: r'placeShowcaseViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PlaceShowcaseViewModelProvider call(String placeId) =>
      PlaceShowcaseViewModelProvider._(argument: placeId, from: this);

  @override
  String toString() => r'placeShowcaseViewModelProvider';
}

abstract class _$PlaceShowcaseViewModel extends $Notifier<PlaceShowcaseState> {
  late final _$args = ref.$arg as String;
  String get placeId => _$args;

  PlaceShowcaseState build(String placeId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PlaceShowcaseState, PlaceShowcaseState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PlaceShowcaseState, PlaceShowcaseState>,
              PlaceShowcaseState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
