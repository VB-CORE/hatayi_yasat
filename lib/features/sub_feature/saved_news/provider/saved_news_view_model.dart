import 'dart:async';

import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/main/news_jobs/model/news_feed_model.dart';
import 'package:lifeclient/features/main/news_jobs/provider/news_jobs_provider.dart';
import 'package:lifeclient/features/sub_feature/saved_news/provider/saved_news_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saved_news_view_model.g.dart';

@riverpod
final class SavedNewsViewModel extends _$SavedNewsViewModel
    with ProjectDependencyMixin {
  static const _whereInChunkSize = 30;

  @override
  SavedNewsState build() {
    final bookmarkedIds = _bookmarkedIds;
    if (bookmarkedIds.isEmpty) {
      return const SavedNewsState();
    }
    unawaited(_resolve(bookmarkedIds));
    return const SavedNewsState(isFetching: true);
  }

  void retry() {
    final bookmarkedIds = _bookmarkedIds;
    state = state.copyWith(isFetching: true, isError: false);
    unawaited(_resolve(bookmarkedIds));
  }

  List<String> get _bookmarkedIds =>
      productCache.newsBookmarkCache.getAll().map((e) => e.newsId).toList();

  Future<void> _resolve(List<String> bookmarkedIds) async {
    if (bookmarkedIds.isEmpty) {
      state = state.copyWith(newsItems: const [], isFetching: false);
      return;
    }

    try {
      final newsById = <String, NewsFeedModel>{};
      for (var i = 0; i < bookmarkedIds.length; i += _whereInChunkSize) {
        final end = (i + _whereInChunkSize < bookmarkedIds.length)
            ? i + _whereInChunkSize
            : bookmarkedIds.length;
        final chunk = bookmarkedIds.sublist(i, end);

        final query = ref
            .read(newsJobsProviderProvider.notifier)
            .fetchNewsByIds(chunk);
        final snapshot = await query.get();

        for (final doc in snapshot.docs) {
          if (doc.data() case final model?) newsById[model.documentId] = model;
        }
      }

      final orderedNews = bookmarkedIds
          .map((id) => newsById[id])
          .whereType<NewsFeedModel>()
          .toList();

      if (!ref.mounted) return;
      state = state.copyWith(
        newsItems: orderedNews,
        isFetching: false,
        isError: false,
      );
    } on Object {
      if (!ref.mounted) return;
      state = state.copyWith(isFetching: false, isError: true);
    }
  }
}
