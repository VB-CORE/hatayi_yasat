import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/community/groups/provider/groups_state.dart';
import 'package:lifeclient/features/community/model/group_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'groups_view_model.g.dart';

@riverpod
final class GroupsViewModel extends _$GroupsViewModel
    with ProjectDependencyMixin {
  @override
  GroupsState build() => const GroupsState(groups: [], isFetching: true);

  Future<void> fetchGroups() async {
    state = state.copyWith(isFetching: true, isError: false);
    final result = await firestoreService.getList<GroupModel>(
      model: const GroupModel.empty(),
      path: CollectionPaths.groups,
    );
    state = state.copyWith(
      groups: result.dataOrNull ?? const [],
      isFetching: false,
      isError: !result.isSuccess,
    );
  }
}
