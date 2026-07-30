import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/community/create_group/model/create_group_model.dart';
import 'package:lifeclient/features/community/create_group/provider/create_group_state.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/community/provider/community_image_upload_mixin.dart';
import 'package:lifeclient/features/community/query/community_paths.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_group_view_model.g.dart';

@riverpod
final class CreateGroupViewModel extends _$CreateGroupViewModel
    with ProjectDependencyMixin, CommunityImageUploadMixin {
  @override
  CreateGroupState build() => const CreateGroupState();

  Future<bool> createGroup(CreateGroupModel form) async {
    final authState = ref.read(authViewModelProvider);
    if (authState is! Authenticated || state.isSubmitting) return false;

    state = state.copyWith(isSubmitting: true, isError: false);

    String? coverImageUrl;
    final coverFile = form.coverImageFile;
    if (coverFile != null) {
      coverImageUrl = (await uploadImage(coverFile)).dataOrNull;
      if (coverImageUrl == null) return _failed();
    }

    final groupReference = CommunityPaths.groups.collection.doc();
    final group = GroupModel.fromCategory(
      creatorUid: authState.user.uid,
      name: form.name,
      category: form.category,
      description: form.description,
      imageUrl: coverImageUrl,
    );
    final creator = GroupMemberModel.fromUser(
      authState.user,
      role: GroupMemberRole.admin,
    );

    final result = await firestoreService.batchWrite(
      (batch) => batch
        ..set(groupReference, group.toJson())
        ..set(
          CommunityPaths.members(groupReference.id).collection.doc(creator.uid),
          creator.toJson(),
        ),
    );

    if (!result.isSuccess) {
      await discardImage(coverImageUrl);
      return _failed();
    }

    if (ref.mounted) state = state.copyWith(isSubmitting: false);
    return true;
  }

  bool _failed() {
    if (ref.mounted) state = state.copyWith(isSubmitting: false, isError: true);
    return false;
  }
}
