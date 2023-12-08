import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vbaseproject/core/dependency/index.dart';
import 'package:vbaseproject/features/v2/news_jobs/provider/news_jobs_state.dart';

part 'news_jobs_provider.g.dart';

@riverpod
final class NewsJobsProvider extends _$NewsJobsProvider
    with ProjectDependencyMixin {
  @override
  NewsJobsState build() => NewsJobsState();

  CollectionReference<NewsModel?> fetchNewsCollectionReferance() {
    return firebaseService.collectionReference(
      CollectionPaths.news,
      NewsModel(),
    );
  }
}
