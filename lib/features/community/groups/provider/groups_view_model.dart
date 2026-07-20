import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/community/groups/provider/groups_state.dart';
import 'package:lifeclient/features/community/mock/community_mock_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'groups_view_model.g.dart';

@riverpod
final class GroupsViewModel extends _$GroupsViewModel
    with ProjectDependencyMixin {
  @override
  GroupsState build() => const GroupsState(groups: [], isFetching: true);

  Future<void> fetchGroups() async {
    state = state.copyWith(isFetching: true, isError: false);
    state = state.copyWith(
      groups: CommunityMockData.groups,
      isFetching: false,
    );
  }
}
