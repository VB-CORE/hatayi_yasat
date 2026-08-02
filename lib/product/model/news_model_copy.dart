import 'package:lifeclient/features/main/news_jobs/model/news_feed_model.dart';

final class NewsModelCopy {
  NewsModelCopy({
    required this.documentId,
    this.title,
    this.content,
    this.image,
    this.createdAt,
    this.type,
  });

  factory NewsModelCopy.fromNewsFeedModel(NewsFeedModel model) {
    return NewsModelCopy(
      documentId: model.documentId,
      title: model.title,
      content: model.body,
      image: model.photoUrl,
      createdAt: model.date,
      type: model.type,
    );
  }

  NewsFeedModel toNewsFeedModel() {
    return NewsFeedModel(
      id: documentId,
      title: title,
      body: content,
      photoUrl: image,
      date: createdAt,
      type: type,
    );
  }

  final String? title;
  final String? content;
  final String? image;
  final DateTime? createdAt;
  final String? type;

  final String documentId;
}
