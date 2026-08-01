import 'package:lifeclient/core/dependency/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_bookmark_count_view_model.g.dart';

@riverpod
final class NewsBookmarkCountViewModel extends _$NewsBookmarkCountViewModel
    with ProjectDependencyMixin {
  @override
  int build() => productCache.newsBookmarkCache.getAll().length;
}
