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
    return const UsefulLinksState();
  }

  CollectionReference<UsefulLinksModel?> fetchLinksCollectionReference() {
    return firebaseService.collectionReference(
      CollectionPaths.usefulLinks,
      UsefulLinksModel(),
    );
  }
}
