import 'package:lifeclient/product/navigation/app_router.dart';

/// it's help for navigate to news detail page
final class NewsModelCopy {
  NewsModelCopy({
    required this.documentId,
    this.title,
    this.content,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory NewsModelCopy.fromNewsModel(NewsModel model) {
    return NewsModelCopy(
      documentId: model.documentId,
      title: model.title,
      content: model.content,
      image: model.image,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  NewsModel toNewsModel() {
    return NewsModel(
      documentId: documentId,
      title: title,
      content: content,
      image: image,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  final String? title;
  final String? content;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final String documentId;
}
