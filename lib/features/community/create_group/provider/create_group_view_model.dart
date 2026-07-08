import 'package:flutter/material.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/community/create_group/model/create_group_model.dart';
import 'package:lifeclient/features/community/create_group/provider/create_group_state.dart';
import 'package:lifeclient/features/community/model/group_category_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_group_view_model.g.dart';

@riverpod
final class CreateGroupViewModel extends _$CreateGroupViewModel
    with ProjectDependencyMixin {
  @override
  CreateGroupState build() =>
      const CreateGroupState(categories: [], isFetchingCategories: true);

  // TODO(community): Firestore groups_categories koleksiyonu hazır olunca
  // gerçek sorguya bağlanacak.
  Future<void> fetchCategories() async {
    state = state.copyWith(isFetchingCategories: true);
    state = state.copyWith(
      categories: GroupCategoryModel.mockItems,
      isFetchingCategories: false,
    );
  }

  // TODO(community): Firestore'a gerçek grup oluşturma isteği hazır olunca
  // bağlanacak — gecikme gerçek network çağrısıyla doğal olarak oluşacak,
  // bu satır o zaman kaldırılacak.
  Future<bool> createGroup(CreateGroupModel model) async {
    state = state.copyWith(isSubmitting: true);
    await Future<void>.delayed(Durations.medium2);
    state = state.copyWith(isSubmitting: false);
    return true;
  }
}
