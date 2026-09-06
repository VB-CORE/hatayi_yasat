import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/main/history/provider/history_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_view_model.g.dart';

@riverpod
final class HistoryViewModel extends _$HistoryViewModel
    with ProjectDependencyMixin {
  @override
  HistoryState build() {
    return const HistoryState();
  }

  Query<MemoryModel?> fetchMemoriesQuery() {
    return firestoreService.collectionReference(
      CollectionPaths.memories,
      MemoryModel.empty(),
    );
  }

  void updateSelectedMemoryIndex(int index) {
    state = state.copyWith(selectedMemoryIndex: index);
  }

  void setLoading({required bool isLoading}) {
    state = state.copyWith(isLoading: isLoading);
  }
}
