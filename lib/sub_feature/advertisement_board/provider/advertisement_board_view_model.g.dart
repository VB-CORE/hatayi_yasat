// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertisement_board_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(AdvertisementBoardViewModel)
const advertisementBoardViewModelProvider =
    AdvertisementBoardViewModelProvider._();

final class AdvertisementBoardViewModelProvider extends $NotifierProvider<
    AdvertisementBoardViewModel, AdvertisementBoardState> {
  const AdvertisementBoardViewModelProvider._()
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
    final created = build();
    final ref =
        this.ref as $Ref<AdvertisementBoardState, AdvertisementBoardState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AdvertisementBoardState, AdvertisementBoardState>,
        AdvertisementBoardState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
