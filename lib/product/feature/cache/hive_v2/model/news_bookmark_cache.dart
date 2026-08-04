import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/feature/cache/cache_manager.dart';

final class NewsBookmarkCache with CacheModel, EquatableMixin {
  const NewsBookmarkCache({
    required this.newsId,
    this.title,
    this.body,
    this.photoUrl,
    this.date,
  });

  const NewsBookmarkCache.empty()
    : newsId = '',
      title = null,
      body = null,
      photoUrl = null,
      date = null;

  factory NewsBookmarkCache.fromNewsModel(NewsModel model) {
    return NewsBookmarkCache(
      newsId: model.documentId,
      title: model.title,
      body: model.content,
      photoUrl: model.image,
      date: model.createdAt,
    );
  }

  final String newsId;
  final String? title;
  final String? body;
  final String? photoUrl;
  final DateTime? date;

  NewsModel toNewsModel() {
    return NewsModel(
      documentId: newsId,
      title: title,
      content: body,
      image: photoUrl,
      createdAt: date,
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
      'date': date?.toIso8601String(),
    };
  }

  @override
  String get id => newsId;

  @override
  List<Object?> get props => [newsId, title, body, photoUrl, date];
}
