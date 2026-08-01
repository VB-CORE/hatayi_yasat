import 'package:lifeclient/features/main/news_jobs/model/news_author_model.dart';
import 'package:lifeclient/features/main/news_jobs/model/news_feed_model.dart';

/// it's help for navigate to news detail page
final class NewsModelCopy {
  NewsModelCopy({
    required this.documentId,
    this.title,
    this.content,
    this.image,
    this.createdAt,
    this.type,
    this.author,
  });

  factory NewsModelCopy.fromNewsFeedModel(NewsFeedModel model) {
    return NewsModelCopy(
      documentId: model.documentId,
      title: model.title,
      content: model.body,
      image: model.photoUrl,
      createdAt: model.date,
      type: model.type,
      author: model.author,
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
      author: author,
    );
  }

  final String? title;
  final String? content;
  final String? image;
  final DateTime? createdAt;
  final String? type;
  final NewsAuthorModel? author;

  final String documentId;
}
