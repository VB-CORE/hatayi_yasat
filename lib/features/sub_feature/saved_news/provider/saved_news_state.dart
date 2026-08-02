import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lifeclient/features/main/news_jobs/model/news_feed_model.dart';

@immutable
final class SavedNewsState extends Equatable {
  const SavedNewsState({
    this.newsItems = const [],
  });

  final List<NewsFeedModel> newsItems;

  @override
  List<Object?> get props => [newsItems];

  SavedNewsState copyWith({
    List<NewsFeedModel>? newsItems,
  }) {
    return SavedNewsState(
      newsItems: newsItems ?? this.newsItems,
    );
  }
}
