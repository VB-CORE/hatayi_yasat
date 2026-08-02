import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/main/news_jobs/model/news_feed_model.dart';
import 'package:lifeclient/product/feature/cache/cache_manager.dart';

final class NewsBookmarkCache with CacheModel, EquatableMixin {
  const NewsBookmarkCache({
    required this.newsId,
    this.title,
    this.body,
    this.photoUrl,
    this.type,
    this.date,
  });

  const NewsBookmarkCache.empty()
    : newsId = '',
      title = null,
      body = null,
      photoUrl = null,
      type = null,
      date = null;

  factory NewsBookmarkCache.fromNewsFeedModel(NewsFeedModel model) {
    return NewsBookmarkCache(
      newsId: model.documentId,
      title: model.title,
      body: model.body,
      photoUrl: model.photoUrl,
      type: model.type,
      date: model.date,
    );
  }

  final String newsId;
  final String? title;
  final String? body;
  final String? photoUrl;
  final String? type;
  final DateTime? date;

  NewsFeedModel toNewsFeedModel() {
    return NewsFeedModel(
      id: newsId,
      title: title,
      body: body,
      photoUrl: photoUrl,
      type: type,
      date: date,
    );
  }

  @override
  NewsBookmarkCache fromDynamicJson(dynamic json) {
    if (json is! Map<String, dynamic>) throw Exception('Invalid json type');
    final id = json['id'];
    if (id is! String) throw Exception('Invalid id type');
    final rawDate = json['date'];
    return NewsBookmarkCache(
      newsId: id,
      title: json['title'] as String?,
      body: json['body'] as String?,
      photoUrl: json['photoUrl'] as String?,
      type: json['type'] as String?,
      date: rawDate is String ? DateTime.tryParse(rawDate) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': newsId,
      'title': title,
      'body': body,
      'photoUrl': photoUrl,
      'type': type,
      'date': date?.toIso8601String(),
    };
  }

  @override
  String get id => newsId;

  @override
  List<Object?> get props => [newsId, title, body, photoUrl, type, date];
}
