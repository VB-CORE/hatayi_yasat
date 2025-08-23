// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developers_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(DevelopersViewModel)
const developersViewModelProvider = DevelopersViewModelProvider._();

final class DevelopersViewModelProvider
    extends $NotifierProvider<DevelopersViewModel, DevelopersState> {
  const DevelopersViewModelProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'developersViewModelProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$developersViewModelHash();

  @$internal
  @override
  DevelopersViewModel create() => DevelopersViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DevelopersState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DevelopersState>(value),
    );
  }
}

String _$developersViewModelHash() =>
    r'4bfc0480b999629d7a4c1a984f3210775a3bc4b6';

abstract class _$DevelopersViewModel extends $Notifier<DevelopersState> {
  DevelopersState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DevelopersState, DevelopersState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<DevelopersState, DevelopersState>,
        DevelopersState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
