// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertisement_board_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdvertisementBoardViewModel)
final advertisementBoardViewModelProvider =
    AdvertisementBoardViewModelProvider._();

final class AdvertisementBoardViewModelProvider
    extends
        $NotifierProvider<
          AdvertisementBoardViewModel,
          AdvertisementBoardState
        > {
  AdvertisementBoardViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'advertisementBoardViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$advertisementBoardViewModelHash();

  @$internal
  @override
  AdvertisementBoardViewModel create() => AdvertisementBoardViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdvertisementBoardState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdvertisementBoardState>(value),
    );
  }
}

String _$advertisementBoardViewModelHash() =>
    r'ef4bfc41b7665277edc2e031416c181f846e4cfa';

abstract class _$AdvertisementBoardViewModel
    extends $Notifier<AdvertisementBoardState> {
  AdvertisementBoardState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AdvertisementBoardState, AdvertisementBoardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdvertisementBoardState, AdvertisementBoardState>,
              AdvertisementBoardState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
