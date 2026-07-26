import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/community/group_detail/provider/group_detail_state.dart';
import 'package:lifeclient/features/community/model/group_model.dart';
import 'package:lifeclient/features/community/query/community_paths.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_detail_view_model.g.dart';

@riverpod
final class GroupDetailViewModel extends _$GroupDetailViewModel
    with ProjectDependencyMixin {
  @override
  GroupDetailState build(String groupId) {
    final subscription = firestoreService
        .collectionReference(CommunityPaths.groups, const GroupModel.empty())
        .doc(groupId)
        .snapshots()
        .listen(_onSnapshot, onError: _onError);
    ref.onDispose(subscription.cancel);
    return const GroupDetailState();
  }

  void _onSnapshot(DocumentSnapshot<GroupModel?> snapshot) {
    final group = snapshot.data();
    if (group == null) return;
    state = state.copyWith(group: group.copyWith(id: snapshot.id));
  }

  void _onError(Object _) => state = state.copyWith(isError: true);
}
