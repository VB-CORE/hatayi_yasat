import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/community/create_group/model/create_group_model.dart';
import 'package:lifeclient/features/community/create_group/provider/create_group_state.dart';
import 'package:lifeclient/features/community/mock/community_mock_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

  // TODO(community): Firestore servis PR'ında model gerçek isteğe gönderilecek.
  Future<bool> createGroup(CreateGroupModel model) async {
    state = state.copyWith(isSubmitting: true);
    await Future<void>.delayed(const Duration(milliseconds: 300));
    state = state.copyWith(isSubmitting: false);
    return true;
  }
}
