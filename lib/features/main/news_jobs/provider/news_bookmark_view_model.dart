import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/main/news_jobs/model/news_feed_model.dart';
import 'package:lifeclient/features/main/news_jobs/provider/news_bookmark_state.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/news_bookmark_cache.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_bookmark_view_model.g.dart';

@riverpod
final class NewsBookmarkViewModel extends _$NewsBookmarkViewModel
    with ProjectDependencyMixin {
  @override
  NewsBookmarkState build(String newsId) {
    return NewsBookmarkState(isSaved: _isSaved);
  }

  void toggle(NewsFeedModel news) {
    if (state.isProcessing) return;

    final willSave = !state.isSaved;
    state = state.copyWith(isSaved: willSave, isProcessing: true);

    try {
      if (willSave) {
        productCache.newsBookmarkCache.add(
          NewsBookmarkCache.fromNewsFeedModel(news),
        );
      } else {
        productCache.newsBookmarkCache.delete(
          NewsBookmarkCache(newsId: newsId),
        );
      }
      state = state.copyWith(isSaved: _isSaved, isProcessing: false);
      ref.invalidate(newsBookmarkCountViewModelProvider);
    } on Object {
      state = state.copyWith(isSaved: !willSave, isProcessing: false);
    }
  }

  bool get _isSaved => productCache.newsBookmarkCache.get(newsId) != null;
}

@riverpod
final class NewsBookmarkCountViewModel extends _$NewsBookmarkCountViewModel
    with ProjectDependencyMixin {
  @override
  int build() => productCache.newsBookmarkCache.getAll().length;
}
