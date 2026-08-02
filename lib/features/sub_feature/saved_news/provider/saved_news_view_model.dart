import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/features/sub_feature/saved_news/provider/saved_news_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saved_news_view_model.g.dart';

@riverpod
final class SavedNewsViewModel extends _$SavedNewsViewModel
    with ProjectDependencyMixin {
  @override
  SavedNewsState build() {
    final newsItems = productCache.newsBookmarkCache
        .getAll()
        .map((cache) => cache.toNewsFeedModel())
        .toList();
    return SavedNewsState(newsItems: newsItems);
  }
}
