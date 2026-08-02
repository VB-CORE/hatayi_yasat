import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/main/news_jobs/model/news_feed_model.dart';
import 'package:lifeclient/features/main/news_jobs/provider/news_jobs_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_jobs_provider.g.dart';

@riverpod
final class NewsJobsProvider extends _$NewsJobsProvider
    with ProjectDependencyMixin {
  @override
  NewsJobsState build() => NewsJobsState();

  Query<NewsFeedModel?> fetchNewsCollectionReference() {
    return firestoreService.queryWithOrderBy(
      path: CollectionPaths.news,
      model: const NewsFeedModel.empty(),
      orderBy: const MapEntry('createdAt', true),
    );
  }

  Query<NewsFeedModel?> fetchNewsByIds(List<String> ids) {
    assert(ids.length <= 30, 'fetchNewsByIds supports at most 30 ids');
    return fetchNewsCollectionReference().where(
      FieldPath.documentId,
      whereIn: ids,
    );
  }

  CollectionReference<AdvertiseModel?> fetchJobsCollectionReference() {
    return firebaseService.collectionReference(
      CollectionPaths.approvedAdvertise,
      AdvertiseModel(),
    );
  }
}
