import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class PostLikeState extends Equatable {
  const PostLikeState({
    this.isLiked = false,
    this.isFetching = false,
    this.isProcessing = false,
  });

  final bool isLiked;
  final bool isFetching;
  final bool isProcessing;

  @override
  List<Object?> get props => [isLiked, isFetching, isProcessing];

  PostLikeState copyWith({
    bool? isLiked,
    bool? isFetching,
    bool? isProcessing,
  }) {
    return PostLikeState(
      isLiked: isLiked ?? this.isLiked,
      isFetching: isFetching ?? this.isFetching,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}
