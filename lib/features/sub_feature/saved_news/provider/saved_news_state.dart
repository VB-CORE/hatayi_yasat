import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lifeclient/features/main/news_jobs/model/news_feed_model.dart';

@immutable
final class SavedNewsState extends Equatable {
  const SavedNewsState({
    this.newsItems = const [],
    this.isFetching = false,
    this.isError = false,
  });

  final List<NewsFeedModel> newsItems;
  final bool isFetching;
  final bool isError;

  @override
  List<Object?> get props => [newsItems, isFetching, isError];

  SavedNewsState copyWith({
    List<NewsFeedModel>? newsItems,
    bool? isFetching,
    bool? isError,
  }) {
    return SavedNewsState(
      newsItems: newsItems ?? this.newsItems,
      isFetching: isFetching ?? this.isFetching,
      isError: isError ?? this.isError,
    );
  }
}
