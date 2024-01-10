import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vbaseproject/features/sub_feature/forms/provider/project_request_state.dart';
import 'package:vbaseproject/product/model/request_project_model.dart';

part 'project_request_provider.g.dart';

@riverpod
final class ProjectRequestProvider extends _$ProjectRequestProvider {
  @override
  ProjectRequestState build() => const ProjectRequestState();

  void updateRequestModel(RequestProjectModel model) {
    state = state.copyWith(requestProjectModel: model);
  }
}
