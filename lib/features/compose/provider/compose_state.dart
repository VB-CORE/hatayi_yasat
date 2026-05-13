import 'dart:io';

import 'package:equatable/equatable.dart';

enum ComposeKind { post, memory, place }

final class ComposePlaceTag extends Equatable {
  const ComposePlaceTag({
    required this.id,
    required this.name,
    required this.district,
  });

  final String id;
  final String name;
  final String district;

  @override
  List<Object?> get props => [id, name, district];
}

final class ComposeState extends Equatable {
  const ComposeState({
    this.kind = ComposeKind.post,
    this.text = '',
    this.selectedPlace,
    this.photos = const [],
    this.year,
    this.era = '',
    this.neighborhood = '',
    this.isSubmitting = false,
    this.errorMessage,
  });

  final ComposeKind kind;
  final String text;
  final ComposePlaceTag? selectedPlace;
  final List<File> photos;
  final int? year;
  final String era;
  final String neighborhood;
  final bool isSubmitting;
  final String? errorMessage;

  bool get canSubmit => !isSubmitting && text.trim().isNotEmpty;

  ComposeState copyWith({
    ComposeKind? kind,
    String? text,
    ComposePlaceTag? selectedPlace,
    bool clearPlace = false,
    List<File>? photos,
    int? year,
    String? era,
    String? neighborhood,
    bool? isSubmitting,
    String? errorMessage,
    bool clearError = false,
  }) => ComposeState(
    kind: kind ?? this.kind,
    text: text ?? this.text,
    selectedPlace: clearPlace ? null : (selectedPlace ?? this.selectedPlace),
    photos: photos ?? this.photos,
    year: year ?? this.year,
    era: era ?? this.era,
    neighborhood: neighborhood ?? this.neighborhood,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
  );

  @override
  List<Object?> get props => [
    kind,
    text,
    selectedPlace,
    photos,
    year,
    era,
    neighborhood,
    isSubmitting,
    errorMessage,
  ];
}
