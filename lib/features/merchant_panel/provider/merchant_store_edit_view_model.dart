import 'dart:io';

import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_panel_view_model.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_store_edit_state.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_photo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'merchant_store_edit_view_model.g.dart';

@riverpod
final class MerchantStoreEditViewModel extends _$MerchantStoreEditViewModel
    with ProjectDependencyMixin {
  static const int maxPhotoCount = 10;

  @override
  MerchantStoreEditState build(String storeId) {
    final store = ref.read(merchantPanelViewModelProvider).store;
    return MerchantStoreEditState(
      photos: store?.images.map(MerchantPhotoUrl.new).toList() ?? const [],
      category: store?.category,
      openTime: store?.openTime,
      closeTime: store?.closeTime,
      isCommentEnabled: store?.isCommentEnabled ?? true,
    );
  }

  bool isFileSizeValid(File file) =>
      file.lengthSync() <= FileSizes.medium.toByte;

  void addPhoto(File file) {
    if (state.photos.length >= maxPhotoCount) return;
    state = state.copyWith(
      photos: [...state.photos, MerchantPhotoFile(file)],
      isDirty: true,
    );
  }

  void replacePhoto(int index, File file) {
    if (index >= state.photos.length) {
      addPhoto(file);
      return;
    }
    final photos = [...state.photos];
    photos[index] = MerchantPhotoFile(file);
    state = state.copyWith(photos: photos, isDirty: true);
  }

  void removePhotoAt(int index) {
    if (index >= state.photos.length) return;
    final photos = [...state.photos]..removeAt(index);
    state = state.copyWith(photos: photos, isDirty: true);
  }

  void setWorkingHours({String? openTime, String? closeTime}) {
    state = state.copyWith(
      openTime: openTime,
      closeTime: closeTime,
      clearOpenTime: openTime == null,
      clearCloseTime: closeTime == null,
      isDirty: true,
    );
  }

  void selectCategory(CategoryModel category) {
    if (state.category == category) return;
    state = state.copyWith(category: category, isDirty: true);
  }

  void setCommentEnabled({required bool value}) {
    if (state.isCommentEnabled == value) return;
    state = state.copyWith(isCommentEnabled: value, isDirty: true);
  }

  void markDirty() {
    if (state.isDirty) return;
    state = state.copyWith(isDirty: true);
  }

  Future<bool> save({
    required String name,
    required String description,
    required String phone,
    required String address,
  }) async {
    if (state.isSaving || state.photos.isEmpty) return false;
    state = state.copyWith(isSaving: true, isError: false);

    final images = await _uploadPhotos();
    if (images == null) {
      state = state.copyWith(isSaving: false, isError: true);
      return false;
    }

    final result = await firestoreService.updateFields(
      path: CollectionPaths.approvedApplications,
      documentId: storeId,
      fields: {
        'name': name.trim(),
        'description': description.trim(),
        'phone': phone.trim().ext.phoneFormatValue,
        'address': address.trim(),
        'category': state.category?.toJson(),
        'isCommentEnabled': state.isCommentEnabled,
        'images': images,
        'openTime': state.openTime,
        'closeTime': state.closeTime,
        'updatedAt': FirebaseTimeParse.dateTimeToTimestamp(DateTime.now()),
      },
    );

    if (!result.isSuccess) {
      state = state.copyWith(isSaving: false, isError: true);
      return false;
    }

    state = state.copyWith(
      photos: images.map(MerchantPhotoUrl.new).toList(),
      isSaving: false,
      isDirty: false,
    );
    await ref.read(merchantPanelViewModelProvider.notifier).refresh();
    return true;
  }

  Future<List<String>?> _uploadPhotos() async {
    final images = <String>[];
    for (final photo in state.photos) {
      switch (photo) {
        case MerchantPhotoUrl(:final url):
          images.add(url);
        case MerchantPhotoFile(:final file):
          final result = await storageService.uploadImage(
            fileBytes: await file.readAsBytes(),
            root: RootStorageName.approvedApplications,
            key: const Uuid().v4(),
          );
          final url = result.dataOrNull;
          if (url == null) return null;
          images.add(url);
      }
    }
    return images;
  }
}
