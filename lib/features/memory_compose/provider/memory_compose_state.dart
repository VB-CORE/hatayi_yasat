import 'dart:io';

import 'package:equatable/equatable.dart';

final class MemoryComposeState extends Equatable {
  const MemoryComposeState({
    this.title = '',
    this.text = '',
    this.year,
    this.era = '',
    this.neighborhood = '',
    this.photos = const [],
    this.isSubmitting = false,
    this.errorMessage,
  });

  final String title;
  final String text;
  final int? year;
  final String era;
  final String neighborhood;
  final List<File> photos;
  final bool isSubmitting;
  final String? errorMessage;

  bool get canSubmit =>
      !isSubmitting &&
      title.trim().isNotEmpty &&
      text.trim().isNotEmpty &&
      year != null &&
      era.trim().isNotEmpty;

  MemoryComposeState copyWith({
    String? title,
    String? text,
    int? year,
    String? era,
    String? neighborhood,
    List<File>? photos,
    bool? isSubmitting,
    String? errorMessage,
    bool clearError = false,
  }) => MemoryComposeState(
    title: title ?? this.title,
    text: text ?? this.text,
    year: year ?? this.year,
    era: era ?? this.era,
    neighborhood: neighborhood ?? this.neighborhood,
    photos: photos ?? this.photos,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
  );

  @override
  List<Object?> get props => [
    title,
    text,
    year,
    era,
    neighborhood,
    photos,
    isSubmitting,
    errorMessage,
  ];
}
