// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OnboardingViewModel)
final onboardingViewModelProvider = OnboardingViewModelProvider._();

final class OnboardingViewModelProvider
    extends $NotifierProvider<OnboardingViewModel, OnboardingState> {
  OnboardingViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingViewModelHash();

  @$internal
  @override
  OnboardingViewModel create() => OnboardingViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingState>(value),
    );
  }
}

String _$onboardingViewModelHash() =>
    r'3b837ddc015ee07161f732d6c9e8812b7883bb12';

abstract class _$OnboardingViewModel extends $Notifier<OnboardingState> {
  OnboardingState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<OnboardingState, OnboardingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OnboardingState, OnboardingState>,
              OnboardingState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
