import 'dart:async';

import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/sub_feature/developers/provider/developers_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'developers_view_model.g.dart';

@riverpod
final class DevelopersViewModel extends _$DevelopersViewModel
    with ProjectDependencyMixin {
  @override
  DevelopersState build() {
    unawaited(_loadDevelopers());
    return const DevelopersState(isFetching: true);
  }

  Future<void> fetchDevelopers() async {
    state = state.copyWith(isFetching: true, isError: false);
    await _loadDevelopers();
  }

  Future<void> _loadDevelopers() async {
    final result = await firestoreService.getList<DeveloperModel>(
      model: DeveloperModel(),
      path: CollectionPaths.developers,
    );
    state = state.copyWith(
      developers: result.dataOrNull ?? const [],
      isFetching: false,
      isError: !result.isSuccess,
    );
  }
}
