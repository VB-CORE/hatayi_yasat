// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'useful_links_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(UsefulLinksViewModel)
const usefulLinksViewModelProvider = UsefulLinksViewModelProvider._();

final class UsefulLinksViewModelProvider
    extends $NotifierProvider<UsefulLinksViewModel, UsefulLinksState> {
  const UsefulLinksViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'usefulLinksViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$usefulLinksViewModelHash();

  @$internal
  @override
  UsefulLinksViewModel create() => UsefulLinksViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UsefulLinksState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UsefulLinksState>(value),
    );
  }
}

String _$usefulLinksViewModelHash() =>
    r'02a7869d452e770c783e3a8daaf71c2173a1965c';

abstract class _$UsefulLinksViewModel extends $Notifier<UsefulLinksState> {
  UsefulLinksState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<UsefulLinksState, UsefulLinksState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<UsefulLinksState, UsefulLinksState>,
        UsefulLinksState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
