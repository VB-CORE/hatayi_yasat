// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developers_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DevelopersViewModel)
final developersViewModelProvider = DevelopersViewModelProvider._();

final class DevelopersViewModelProvider
    extends $NotifierProvider<DevelopersViewModel, DevelopersState> {
  DevelopersViewModelProvider._()
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
    final ref = this.ref as $Ref<DevelopersState, DevelopersState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DevelopersState, DevelopersState>,
              DevelopersState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
