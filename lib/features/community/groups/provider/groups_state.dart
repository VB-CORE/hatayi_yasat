import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class GroupsState extends Equatable {
  const GroupsState({this.selectedCategoryValue, this.isProcessing = false});

  final int? selectedCategoryValue;
  final bool isProcessing;

  @override
  List<Object?> get props => [selectedCategoryValue, isProcessing];

  GroupsState copyWith({
    int? selectedCategoryValue,
    bool clearSelectedCategory = false,
    bool? isProcessing,
  }) {
    return GroupsState(
      selectedCategoryValue: clearSelectedCategory
          ? null
          : selectedCategoryValue ?? this.selectedCategoryValue,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}
