import 'dart:io';

import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/compose/provider/compose_state.dart';
import 'package:lifeclient/product/repository/memories/memories_repository_provider.dart';
import 'package:lifeclient/product/repository/memories/memory_input.dart';
import 'package:lifeclient/product/repository/posts/post_input.dart';
import 'package:lifeclient/product/repository/posts/posts_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'compose_view_model.g.dart';

@riverpod
final class ComposeViewModel extends _$ComposeViewModel
    with ProjectDependencyMixin {
  @override
  ComposeState build({ComposeKind initialKind = ComposeKind.post}) {
    return ComposeState(kind: initialKind);
  }

  void setKind(ComposeKind kind) => state = state.copyWith(kind: kind);

  void setText(String value) => state = state.copyWith(text: value);

  void setYear(int? value) => state = state.copyWith(year: value);

  void setEra(String value) => state = state.copyWith(era: value);

  void setNeighborhood(String value) =>
      state = state.copyWith(neighborhood: value);

  void pickPlace(ComposePlaceTag place) =>
      state = state.copyWith(selectedPlace: place);

  void clearPlace() => state = state.copyWith(clearPlace: true);

  void addPhoto(File file) {
    final next = List<File>.of(state.photos)..add(file);
    state = state.copyWith(photos: next);
  }

  void removePhoto(int index) {
    if (index < 0 || index >= state.photos.length) return;
    final next = List<File>.of(state.photos)..removeAt(index);
    state = state.copyWith(photos: next);
  }

  /// Submit the post / memory through the matching repository. Returns
  /// the new doc id on success or `null` on failure (errorMessage on
  /// state).
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
      if (state.kind == ComposeKind.memory) {
        final repo = ref.read(memoriesRepositoryProvider);
        final id = await repo.create(
          CreateMemoryInput(
            cityId: cityId,
            title: state.text.split('\n').first,
            text: state.text,
            year: state.year ?? DateTime.now().year,
            era: state.era,
            neighborhood: state.neighborhood,
            photoFiles: state.photos,
          ),
        );
        state = state.copyWith(isSubmitting: false);
        return id;
      } else {
        final repo = ref.read(postsRepositoryProvider);
        final id = await repo.create(
          CreatePostInput(
            cityId: cityId,
            text: state.text,
            photoFiles: state.photos,
            placeId: state.selectedPlace?.id,
            placeName: state.selectedPlace?.name,
            placeDistrict: state.selectedPlace?.district,
            isMemory: false,
          ),
        );
        state = state.copyWith(isSubmitting: false);
        return id;
      }
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: e.toString(),
      );
      return null;
    }
  }
}
