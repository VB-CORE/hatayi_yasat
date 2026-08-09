import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/sub_feature/useful_links/provider/useful_links_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'useful_links_view_model.g.dart';

@riverpod
final class UsefulLinksViewModel extends _$UsefulLinksViewModel
    with ProjectDependencyMixin {
  @override
  UsefulLinksState build() {
    unawaited(_fetchCount());

    return const UsefulLinksState();
  }

  CollectionReference<UsefulLinksModel?> fetchLinksCollectionReference() {
    return firestoreService.collectionReference(
      CollectionPaths.usefulLinks,
      UsefulLinksModel(),
    );
  }

  Future<void> _fetchCount() async {
    final result = await firestoreService.countQuery(
      fetchLinksCollectionReference(),
    );

    if (result case FirebaseSuccess(:final data)) {
      state = state.copyWith(count: data);
    }
  }
}
