import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lifeclient/features/community/model/group_category_model.dart';

@immutable
final class CreateGroupState extends Equatable {
  const CreateGroupState({
    required this.categories,
    this.isFetchingCategories = false,
    this.isSubmitting = false,
  });

  final List<GroupCategoryModel> categories;
  final bool isFetchingCategories;
  final bool isSubmitting;

  @override
  List<Object?> get props => [
    categories,
    isFetchingCategories,
    isSubmitting,
  ];

  CreateGroupState copyWith({
    List<GroupCategoryModel>? categories,
    bool? isFetchingCategories,
    bool? isSubmitting,
  }) {
    return CreateGroupState(
      categories: categories ?? this.categories,
      isFetchingCategories: isFetchingCategories ?? this.isFetchingCategories,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
