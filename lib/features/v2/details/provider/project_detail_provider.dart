import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vbaseproject/features/v2/details/provider/project_detail_state.dart';

part 'project_detail_provider.g.dart';

@riverpod
final class ProjectDetailProvider extends _$ProjectDetailProvider {
  @override
  ProjectDetailState build() => const ProjectDetailState();
}
