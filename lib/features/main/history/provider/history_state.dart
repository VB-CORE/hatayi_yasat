import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
final class HistoryState extends Equatable {
  const HistoryState({
    this.selectedMemoryIndex = 0,
    this.isLoading = false,
  });

  final int selectedMemoryIndex;
  final bool isLoading;

  @override
  List<Object?> get props => [selectedMemoryIndex, isLoading];

  HistoryState copyWith({
    int? selectedMemoryIndex,
    bool? isLoading,
  }) {
    return HistoryState(
      selectedMemoryIndex: selectedMemoryIndex ?? this.selectedMemoryIndex,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
