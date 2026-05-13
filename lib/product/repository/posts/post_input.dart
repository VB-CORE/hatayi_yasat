import 'dart:io';

/// Input passed to `PostsRepository.create`. The repository handles
/// uploading [photoFiles] to Storage and then writes the Firestore doc.
final class CreatePostInput {
  const CreatePostInput({
    required this.cityId,
    required this.text,
    required this.photoFiles,
    this.placeId,
    this.placeName,
    this.placeDistrict,
    this.isMemory = false,
    this.year,
  });

  final String cityId;
  final String text;
  final List<File> photoFiles;
  final String? placeId;
  final String? placeName;
  final String? placeDistrict;
  final bool isMemory;
  final int? year;
}
