import 'dart:io';

final class CreateMemoryInput {
  const CreateMemoryInput({
    required this.cityId,
    required this.title,
    required this.text,
    required this.year,
    required this.era,
    required this.neighborhood,
    required this.photoFiles,
  });

  final String cityId;
  final String title;
  final String text;
  final int year;
  final String era;
  final String neighborhood;
  final List<File> photoFiles;
}
