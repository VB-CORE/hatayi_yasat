// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_community_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RateCommunityViewModel)
final rateCommunityViewModelProvider = RateCommunityViewModelFamily._();

final class RateCommunityViewModelProvider
    extends $NotifierProvider<RateCommunityViewModel, RateCommunityState> {
  RateCommunityViewModelProvider._({
    required RateCommunityViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'rateCommunityViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$rateCommunityViewModelHash();

  @override
  String toString() {
    return r'rateCommunityViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RateCommunityViewModel create() => RateCommunityViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RateCommunityState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RateCommunityState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RateCommunityViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$rateCommunityViewModelHash() =>
    r'b9a24205ae81b7cb259ba6ffd746a3aec44f88ad';

final class RateCommunityViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          RateCommunityViewModel,
          RateCommunityState,
          RateCommunityState,
          RateCommunityState,
          String
        > {
  RateCommunityViewModelFamily._()
    : super(
        retry: null,
        name: r'rateCommunityViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RateCommunityViewModelProvider call(String placeId) =>
      RateCommunityViewModelProvider._(argument: placeId, from: this);

  @override
  String toString() => r'rateCommunityViewModelProvider';
}

abstract class _$RateCommunityViewModel extends $Notifier<RateCommunityState> {
  late final _$args = ref.$arg as String;
  String get placeId => _$args;

  RateCommunityState build(String placeId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<RateCommunityState, RateCommunityState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RateCommunityState, RateCommunityState>,
              RateCommunityState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
