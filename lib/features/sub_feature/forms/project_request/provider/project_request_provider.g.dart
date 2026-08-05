// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_request_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProjectRequestProvider)
final projectRequestProviderProvider = ProjectRequestProviderProvider._();

final class ProjectRequestProviderProvider
    extends $NotifierProvider<ProjectRequestProvider, ProjectRequestState> {
  ProjectRequestProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectRequestProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectRequestProviderHash();

  @$internal
  @override
  ProjectRequestProvider create() => ProjectRequestProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectRequestState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectRequestState>(value),
    );
  }
}

String _$projectRequestProviderHash() =>
    r'c1e3a56431778e873d9d896bd6b06854d00cf622';

abstract class _$ProjectRequestProvider extends $Notifier<ProjectRequestState> {
  ProjectRequestState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ProjectRequestState, ProjectRequestState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProjectRequestState, ProjectRequestState>,
              ProjectRequestState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
