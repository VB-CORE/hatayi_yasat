import 'package:equatable/equatable.dart';
import 'package:lifeclient/product/feature/cache/cache_manager.dart';

final class NewsBookmarkCache with CacheModel, EquatableMixin {
  const NewsBookmarkCache({required this.newsId});

  const NewsBookmarkCache.empty() : newsId = '';

  final String newsId;

  @override
  NewsBookmarkCache fromDynamicJson(dynamic json) {
    if (json is! Map<String, dynamic>) throw Exception('Invalid json type');
    final id = json['id'];
    if (id is! String) throw Exception('Invalid id type');
    return NewsBookmarkCache(newsId: id);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'id': newsId};
  }

  @override
  String get id => newsId;

  @override
  List<Object> get props => [newsId];
}
