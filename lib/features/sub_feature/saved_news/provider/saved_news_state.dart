import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:life_shared/life_shared.dart';

@immutable
final class SavedNewsState extends Equatable {
  const SavedNewsState({
    this.newsItems = const [],
  });

  final List<NewsModel> newsItems;

  @override
  List<Object?> get props => [newsItems];

  SavedNewsState copyWith({
    List<NewsModel>? newsItems,
  }) {
    return SavedNewsState(
      newsItems: newsItems ?? this.newsItems,
    );
  }
}
