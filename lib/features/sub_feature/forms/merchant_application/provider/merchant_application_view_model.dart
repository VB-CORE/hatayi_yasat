import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_application_model.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/provider/merchant_application_service_provider.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/provider/merchant_application_state.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/model/open_and_close_time_validation_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    final photos = [...state.photoFiles];
    if (index < photos.length) {
      photos[index] = file;
    } else {
      photos.add(file);
    }
    state = state.copyWith(photoFiles: photos);
  }

  void removePhotoAt(int index) {
    if (index >= state.photoFiles.length) return;
    final photos = [...state.photoFiles]..removeAt(index);
    state = state.copyWith(photoFiles: photos);
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

  bool isDocumentSizeValid(File file) =>
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

  Future<bool> submit() async {
    final model = _buildModel();
    if (model == null) return false;
    state = state.copyWith(isSubmitting: true, isError: false);
    final response = await ref
        .read(merchantApplicationServiceProvider)
        .submit(model);
    state = state.copyWith(isSubmitting: false, isError: !response);
    return response;
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
    if (state.photoFiles.isEmpty) return MerchantStepError.photoRequired;
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
    if (category == null || town == null || city == null) return null;
    if (document == null || location == null) return null;

    return MerchantApplicationModel(
      placeName: state.companyName,
      placeDescription: state.companyDescription,
      placeAddress: state.address,
      placeOwnerName: state.ownerName,
      placePhoneNumber: state.phoneNumber,
      placeCategory: category,
      placeDistrict: town.toTownModel,
      photoFiles: state.photoFiles,
      documentFile: document,
      timeValidationModel: OpenAndCloseTimeValidationModel(
        openTime: state.openTime,
        closeTime: state.closeTime,
      ),
      selectedLocation: location,
      selectedCityId: city.documentId,
      isComment: state.isCommentEnabled,
    );
  }
}
