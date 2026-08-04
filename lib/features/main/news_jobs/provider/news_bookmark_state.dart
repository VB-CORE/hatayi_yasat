import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class NewsBookmarkState extends Equatable {
  const NewsBookmarkState({
    this.isSaved = false,
    this.isProcessing = false,
  });

  final bool isSaved;
  final bool isProcessing;

  @override
  List<Object?> get props => [isSaved, isProcessing];

  NewsBookmarkState copyWith({
    bool? isSaved,
    bool? isProcessing,
  }) {
    return NewsBookmarkState(
      isSaved: isSaved ?? this.isSaved,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}
