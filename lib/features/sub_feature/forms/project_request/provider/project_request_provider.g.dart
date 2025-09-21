// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_request_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProjectRequestProvider)
const projectRequestProviderProvider = ProjectRequestProviderProvider._();

final class ProjectRequestProviderProvider
    extends $NotifierProvider<ProjectRequestProvider, ProjectRequestState> {
  const ProjectRequestProviderProvider._()
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
    r'f2b27292a4306f9a51b504e94c4ffd9a5ca89be3';

abstract class _$ProjectRequestProvider extends $Notifier<ProjectRequestState> {
  ProjectRequestState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ProjectRequestState, ProjectRequestState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProjectRequestState, ProjectRequestState>,
              ProjectRequestState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
