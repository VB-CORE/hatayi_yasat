import 'dart:async';

import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/community/provider/group_categories_state.dart';
import 'package:lifeclient/features/community/query/community_paths.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_categories_view_model.g.dart';

@riverpod
final class GroupCategoriesViewModel extends _$GroupCategoriesViewModel
    with ProjectDependencyMixin {
  @override
  GroupCategoriesState build() {
    unawaited(_fetch());
    return const GroupCategoriesState(isFetching: true);
  }

  Future<void> retry() {
    state = state.copyWith(isFetching: true, isError: false);
    return _fetch();
  }

  Future<void> _fetch() async {
    final result = await firestoreService.getList<GroupCategoryModel>(
      model: const GroupCategoryModel.empty(),
      path: CommunityPaths.categories,
    );
    if (!ref.mounted) return;

    state = switch (result) {
      FirebaseSuccess(:final data) => state.copyWith(
        categories: data,
        isFetching: false,
      ),
      FirebaseFailure() => state.copyWith(isFetching: false, isError: true),
    };
  }
}
