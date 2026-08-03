import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
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

  void toggle(NewsModel news) {
    if (state.isProcessing) return;

    final willSave = !state.isSaved;
    state = state.copyWith(isSaved: willSave, isProcessing: true);

    try {
      if (willSave) {
        productCache.newsBookmarkCache.add(
          NewsBookmarkCache.fromNewsModel(news),
        );
      } else {
        productCache.newsBookmarkCache.delete(
          NewsBookmarkCache(newsId: newsId),
        );
      }
      state = state.copyWith(isSaved: _isSaved, isProcessing: false);
      ref.invalidate(newsBookmarkCountProvider);
    } on Object {
      state = state.copyWith(isSaved: !willSave, isProcessing: false);
    }
  }

  bool get _isSaved => productCache.newsBookmarkCache.get(newsId) != null;
}

@riverpod
int newsBookmarkCount(Ref ref) {
  return ProjectDependencyItems.productCache.newsBookmarkCache
      .getAll()
      .length;
}
