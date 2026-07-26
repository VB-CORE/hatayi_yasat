import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:life_shared/life_shared.dart';

@immutable
final class GroupCategoriesState extends Equatable {
  const GroupCategoriesState({
    this.categories = const [],
    this.isFetching = false,
    this.isError = false,
  });

  final List<GroupCategoryModel> categories;
  final bool isFetching;
  final bool isError;

  @override
  List<Object?> get props => [categories, isFetching, isError];

  GroupCategoriesState copyWith({
    List<GroupCategoryModel>? categories,
    bool? isFetching,
    bool? isError,
  }) {
    return GroupCategoriesState(
      categories: categories ?? this.categories,
      isFetching: isFetching ?? this.isFetching,
      isError: isError ?? this.isError,
    );
  }
}
