// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tourism_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TourismViewModel)
final tourismViewModelProvider = TourismViewModelProvider._();

final class TourismViewModelProvider
    extends $NotifierProvider<TourismViewModel, TourismState> {
  TourismViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tourismViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tourismViewModelHash();

  @$internal
  @override
  TourismViewModel create() => TourismViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TourismState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TourismState>(value),
    );
  }
}

String _$tourismViewModelHash() => r'9d01502143b0a1e21559d69d6cda63593c8d81d2';

abstract class _$TourismViewModel extends $Notifier<TourismState> {
  TourismState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TourismState, TourismState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TourismState, TourismState>,
              TourismState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
