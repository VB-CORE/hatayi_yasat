import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/auth/view_model/auth_state.dart';
import 'package:lifeclient/features/auth/view_model/auth_view_model.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_application_model.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_application_step.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_photo.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_step_error.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/provider/merchant_application_state.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/model/open_and_close_time_validation_model.dart';
import 'package:lifeclient/product/model/auth/user/user_application_model.dart';
import 'package:lifeclient/product/model/auth/user/user_model.dart';
import 'package:lifeclient/product/utility/extension/time_of_day_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'merchant_application_view_model.g.dart';

@riverpod
final class MerchantApplicationViewModel extends _$MerchantApplicationViewModel
    with ProjectDependencyMixin {
  @override
  MerchantApplicationState build() {
    final city = ref.read(productProviderState).selectedCity;
    final towns = _townsForCity(city);
    return MerchantApplicationState(
      selectedCity: city,
      townItems: towns,
      selectedTown: towns.isEmpty ? null : towns.first,
    );
  }

  UserModel? get _currentUser {
    final authState = ref.read(authViewModelProvider);
    return authState is Authenticated ? authState.user : null;
  }

  void nextStep() {
    final next = state.currentStep.next;
    if (next == null) return;
    state = state.copyWith(currentStep: next);
  }

  void previousStep() {
    final previous = state.currentStep.previous;
    if (previous == null) return;
    state = state.copyWith(currentStep: previous);
  }

  void goToStep(MerchantApplicationStep step) {
    state = state.copyWith(currentStep: step);
  }

  void setCompanyMode({required bool isNew}) {
    if (state.isNewCompanyMode == isNew) return;
    if (!isNew) {
      state = state.copyWith(isNewCompanyMode: false);
      return;
    }
    final city = ref.read(productProviderState).selectedCity;
    final towns = _townsForCity(city);
    final defaultTown = towns.isEmpty ? null : towns.first;
    state = state.copyWith(
      isNewCompanyMode: true,
      clearSelectedCompany: true,
      clearSelectedCategory: true,
      selectedCity: city,
      townItems: towns,
      selectedTown: defaultTown,
      clearSelectedTown: defaultTown == null,
      clearSelectedLocation: true,
      photos: const [],
    );
  }

  void selectCompany(StoreModel store) {
    final product = ref.read(productProviderState);

    var city = state.selectedCity ?? product.selectedCity;
    if (store.cityId.isNotEmpty) {
      city =
          product.regionalCityItems.firstWhereOrNull(
            (element) => element.documentId == store.cityId,
          ) ??
          city;
    }

    final towns = _townsForCity(city);
    final town =
        towns.firstWhereOrNull((element) => element.code == store.townCode) ??
        (towns.isEmpty ? null : towns.first);

    final latLong = store.latLong;
    final location = latLong != null
        ? LatLng(latLong.latitude, latLong.longitude)
        : state.selectedLocation;

    state = state.copyWith(
      selectedCompany: store,
      selectedCategory: store.category,
      selectedCity: city,
      townItems: towns,
      selectedTown: town,
      clearSelectedTown: town == null,
      selectedLocation: location,
      photos: store.images.map(MerchantPhotoUrl.new).toList(),
    );
  }

  void selectCategory(CategoryModel category) {
    if (state.selectedCategory == category) return;
    state = state.copyWith(selectedCategory: category);
  }

  void selectCity(RegionalCityModel city) {
    final towns = _townsForCity(city);
    final defaultTown = towns.isEmpty ? null : towns.first;
    state = state.copyWith(
      selectedCity: city,
      townItems: towns,
      selectedTown: defaultTown,
      clearSelectedTown: defaultTown == null,
    );
  }

  void selectTown(RegionalTownSubItem town) {
    state = state.copyWith(selectedTown: town);
  }

  void setCompanyText({required String name, required String description}) {
    state = state.copyWith(companyName: name, companyDescription: description);
  }

  void setMediaText({
    required String address,
    TimeOfDay? openTime,
    TimeOfDay? closeTime,
  }) {
    state = state.copyWith(
      address: address,
      openTime: openTime,
      clearOpenTime: openTime == null,
      closeTime: closeTime,
      clearCloseTime: closeTime == null,
    );
  }

  void setOwnerText({required String name, required String phone}) {
    state = state.copyWith(ownerName: name, phoneNumber: phone);
  }

  void setLocation(LatLng location) {
    state = state.copyWith(selectedLocation: location);
  }

  void addOrReplacePhoto(int index, File file) {
    final photos = [...state.photos];
    final photo = MerchantPhotoFile(file);
    if (index < photos.length) {
      photos[index] = photo;
    } else {
      photos.add(photo);
    }
    state = state.copyWith(photos: photos);
  }

  void removePhotoAt(int index) {
    if (index >= state.photos.length) return;
    final photos = [...state.photos]..removeAt(index);
    state = state.copyWith(photos: photos);
  }

  void setDocument(File file) {
    state = state.copyWith(documentFile: file);
  }

  void setKvkkChecked({required bool value}) {
    state = state.copyWith(isKVKKChecked: value);
  }

  void setCommentEnabled({required bool value}) {
    state = state.copyWith(isCommentEnabled: value);
  }

  bool isFileSizeValid(File file) =>
      file.lengthSync() <= FileSizes.large.toByte;

  MerchantStepError? validateStep(
    MerchantApplicationStep step, {
    required bool isFormValid,
  }) => switch (step) {
    MerchantApplicationStep.company => _validateCompany(
      isFormValid: isFormValid,
    ),
    MerchantApplicationStep.media => _validateMedia(isFormValid: isFormValid),
    MerchantApplicationStep.owner => _validateOwner(isFormValid: isFormValid),
  };

  Future<UserApplicationModel?> submit() async {
    final model = _buildModel();
    if (model == null) return null;
    state = state.copyWith(isSubmitting: true, isError: false);
    final application = await _sendApplication(model);
    if (application != null) {
      ref.read(authViewModelProvider.notifier).updateApplication(application);
    }
    state = state.copyWith(
      isSubmitting: false,
      isError: application == null,
    );
    return application;
  }

  Future<UserApplicationModel?> _sendApplication(
    MerchantApplicationModel model,
  ) async {
    final images = await _uploadImages(model);
    if (images == null) return null;
    final documentUrl = await _uploadDocument(model.documentFile);
    if (documentUrl == null) return null;

    final deviceId = await ''.ext.deviceId;
    final now = DateTime.now();
    final storeReference = CollectionPaths.unApprovedApplications.collection
        .doc();
    final userReference = CollectionPaths.users.collection.doc(model.ownerId);

    final store = StoreModel(
      name: model.placeName,
      owner: model.placeOwnerName,
      description: model.placeDescription,
      address: model.placeAddress,
      phone: model.placePhoneNumber.ext.phoneFormatValue,
      images: images,
      townCode: model.placeDistrict.code ?? 0,
      cityId: model.selectedCityId,
      isCommentEnabled: model.isComment,
      isApproved: false,
      openTime: model.timeValidationModel.openTime?.stringValue,
      closeTime: model.timeValidationModel.closeTime?.stringValue,
      deviceID: deviceId,
      category: model.placeCategory,
      latLong: GeoPoint(
        model.selectedLocation.latitude,
        model.selectedLocation.longitude,
      ),
      createdAt: now,
      updatedAt: now,
    );
    final record = UserApplicationModel(
      id: storeReference.id,
      ownershipDocumentUrl: documentUrl,
      createdAt: now,
      updatedAt: now,
    );

    final result = await firestoreService.batchWrite(
      (batch) => batch
        ..set(storeReference, store.toJson())
        ..update(userReference, UserModel.updateFields(application: record)),
    );
    return result.isSuccess ? record : null;
  }

  Future<List<String>?> _uploadImages(MerchantApplicationModel model) async {
    final images = <String>[...model.photoUrls];
    for (final file in model.photoFiles) {
      final bytes = await file.readAsBytes();
      final result = await storageService.uploadImage(
        fileBytes: bytes,
        root: RootStorageName.pending,
        key: const Uuid().v4(),
      );
      final url = result.dataOrNull;
      if (url == null) return null;
      images.add(url);
    }
    return images;
  }

  Future<String?> _uploadDocument(File file) async {
    final result = await storageService.uploadFile(
      file: file,
      root: RootStorageName.pending,
      key: const Uuid().v4(),
      size: FileSizes.large,
    );
    return result.dataOrNull;
  }

  MerchantStepError? _validateCompany({required bool isFormValid}) {
    if (!isFormValid) return MerchantStepError.form;
    if (!state.isNewCompanyMode && state.selectedCompany == null) {
      return MerchantStepError.companyNotSelected;
    }
    if (state.selectedCategory == null) return MerchantStepError.categoryEmpty;
    return null;
  }

  MerchantStepError? _validateMedia({required bool isFormValid}) {
    if (!isFormValid) return MerchantStepError.form;
    if (state.photos.isEmpty) return MerchantStepError.photoRequired;
    return null;
  }

  MerchantStepError? _validateOwner({required bool isFormValid}) {
    if (!isFormValid) {
      return state.isKVKKChecked
          ? MerchantStepError.form
          : MerchantStepError.kvkkRequired;
    }
    if (state.documentFile == null) return MerchantStepError.documentRequired;
    return null;
  }

  List<RegionalTownSubItem> _townsForCity(RegionalCityModel city) {
    final townItems = ref.read(productProviderState).regionalTownItems;
    if (townItems.isEmpty) return const [];
    final townModel = townItems.firstWhere(
      (element) => element.cityId == city.documentId,
      orElse: () => townItems.first,
    );
    return townModel.towns;
  }

  MerchantApplicationModel? _buildModel() {
    final category = state.selectedCategory;
    final town = state.selectedTown;
    final city = state.selectedCity;
    final document = state.documentFile;
    final location = state.selectedLocation;
    final ownerId = _currentUser?.uid;
    if (category == null || town == null || city == null) return null;
    if (document == null || location == null || ownerId == null) return null;

    final photoFiles = <File>[];
    final photoUrls = <String>[];
    for (final photo in state.photos) {
      switch (photo) {
        case MerchantPhotoFile(:final file):
          photoFiles.add(file);
        case MerchantPhotoUrl(:final url):
          photoUrls.add(url);
      }
    }

    return MerchantApplicationModel(
      placeName: state.companyName,
      placeDescription: state.companyDescription,
      placeAddress: state.address,
      placeOwnerName: state.ownerName,
      placePhoneNumber: state.phoneNumber,
      placeCategory: category,
      placeDistrict: town.toTownModel,
      photoFiles: photoFiles,
      photoUrls: photoUrls,
      documentFile: document,
      timeValidationModel: OpenAndCloseTimeValidationModel(
        openTime: state.openTime,
        closeTime: state.closeTime,
      ),
      selectedLocation: location,
      selectedCityId: city.documentId,
      isComment: state.isCommentEnabled,
      ownerId: ownerId,
    );
  }
}
