import 'package:life_shared/life_shared.dart';

final class NewsEmptyModel {
  const NewsEmptyModel._();
  static NewsModel empty = NewsModel(
    title: '',
    content: '',
    image: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
