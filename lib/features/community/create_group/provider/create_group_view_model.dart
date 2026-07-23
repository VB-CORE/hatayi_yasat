import 'dart:io';

import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/create_group/model/create_group_model.dart';
import 'package:lifeclient/features/community/create_group/provider/create_group_state.dart';
import 'package:lifeclient/features/community/groups/provider/groups_view_model.dart';
import 'package:lifeclient/features/community/mock/community_mock_data.dart';
import 'package:lifeclient/features/community/model/group_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'create_group_view_model.g.dart';

@riverpod
final class CreateGroupViewModel extends _$CreateGroupViewModel
    with ProjectDependencyMixin {
  @override
  CreateGroupState build() =>
      const CreateGroupState(categories: [], isFetchingCategories: true);

  Future<void> fetchCategories() async {
    state = state.copyWith(isFetchingCategories: true);
    state = state.copyWith(
      categories: CommunityMockData.categories,
      isFetchingCategories: false,
    );
  }

  Future<bool> createGroup(CreateGroupModel model) async {
    final authState = ref.read(authViewModelProvider);
    if (authState is! Authenticated) return false;

    state = state.copyWith(isSubmitting: true);

    final imageUrl = await _uploadCoverImage(model.coverImageFile);
    final group = GroupModel(
      creatorUid: authState.user.uid,
      name: model.name,
      description: model.description,
      imageUrl: imageUrl,
    );
    final result = await firestoreService.add<GroupModel>(
      model: group,
      path: CollectionPaths.groups,
    );

    state = state.copyWith(isSubmitting: false);
    if (result.dataOrNull == null) return false;

    await ref.read(groupsViewModelProvider.notifier).fetchGroups();
    return true;
  }

  Future<String?> _uploadCoverImage(File? file) async {
    if (file == null) return null;
    try {
      final bytes = await file.readAsBytes();
      final result = await storageService.uploadImage(
        root: RootStorageName.company,
        key: const Uuid().v4(),
        fileBytes: bytes,
      );
      return result.dataOrNull;
    } on Exception {
      return null;
    }
  }
}
