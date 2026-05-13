import 'dart:io';

import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/memory_compose/provider/memory_compose_state.dart';
import 'package:lifeclient/product/repository/memories/memories_repository_provider.dart';
import 'package:lifeclient/product/repository/memories/memory_input.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'memory_compose_view_model.g.dart';

@riverpod
final class MemoryComposeViewModel extends _$MemoryComposeViewModel
    with ProjectDependencyMixin {
  @override
  MemoryComposeState build() => const MemoryComposeState();

  void setTitle(String value) => state = state.copyWith(title: value);
  void setText(String value) => state = state.copyWith(text: value);
  void setYear(int? value) => state = state.copyWith(year: value);
  void setEra(String value) => state = state.copyWith(era: value);
  void setNeighborhood(String value) =>
      state = state.copyWith(neighborhood: value);

  void addPhoto(File file) {
    state = state.copyWith(photos: [...state.photos, file]);
  }

  void removePhoto(int index) {
    if (index < 0 || index >= state.photos.length) return;
    final next = List<File>.of(state.photos)..removeAt(index);
    state = state.copyWith(photos: next);
  }

  Future<String?> submit() async {
    if (!state.canSubmit) return null;
    state = state.copyWith(isSubmitting: true, clearError: true);
    final cityName = ref
        .read(productProviderState)
        .selectedCity
        .name
        .toLowerCase();
    final cityId = cityName.isEmpty ? 'hatay' : cityName;
    try {
      final id = await ref
          .read(memoriesRepositoryProvider)
          .create(
            CreateMemoryInput(
              cityId: cityId,
              title: state.title,
              text: state.text,
              year: state.year!,
              era: state.era,
              neighborhood: state.neighborhood,
              photoFiles: state.photos,
            ),
          );
      state = state.copyWith(isSubmitting: false);
      return id;
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: e.toString(),
      );
      return null;
    }
  }
}
