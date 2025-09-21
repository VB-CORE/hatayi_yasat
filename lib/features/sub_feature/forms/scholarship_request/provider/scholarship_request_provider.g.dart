// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scholarship_request_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScholarshipRequestProvider)
const scholarshipRequestProviderProvider =
    ScholarshipRequestProviderProvider._();

final class ScholarshipRequestProviderProvider
    extends
        $NotifierProvider<ScholarshipRequestProvider, ScholarshipRequestState> {
  const ScholarshipRequestProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scholarshipRequestProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scholarshipRequestProviderHash();

  @$internal
  @override
  ScholarshipRequestProvider create() => ScholarshipRequestProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScholarshipRequestState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScholarshipRequestState>(value),
    );
  }
}

String _$scholarshipRequestProviderHash() =>
    r'b11fdbd64f8bed6cdf46a96d3366d89ae4b68788';

abstract class _$ScholarshipRequestProvider
    extends $Notifier<ScholarshipRequestState> {
  ScholarshipRequestState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<ScholarshipRequestState, ScholarshipRequestState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ScholarshipRequestState, ScholarshipRequestState>,
              ScholarshipRequestState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
