import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';

enum MerchantApplicationStep {
  company,
  media,
  owner;

  String get titleKey => switch (this) {
    MerchantApplicationStep.company =>
      LocaleKeys.merchantApplication_steps_company,
    MerchantApplicationStep.media => LocaleKeys.merchantApplication_steps_media,
    MerchantApplicationStep.owner => LocaleKeys.merchantApplication_steps_owner,
  };

  MerchantApplicationStep? get next =>
      index + 1 < values.length ? values[index + 1] : null;

  MerchantApplicationStep? get previous => index > 0 ? values[index - 1] : null;
}

enum MerchantStepError {
  form,
  companyNotSelected,
  categoryEmpty,
  photoRequired,
  kvkkRequired,
  documentRequired,
}

final class MerchantApplicationState extends Equatable {
  const MerchantApplicationState({
    this.selectedCompany,
    this.currentStep = MerchantApplicationStep.company,
    this.isNewCompanyMode = false,
    this.companyName = '',
    this.companyDescription = '',
    this.selectedCategory,
    this.selectedCity,
    this.townItems = const [],
    this.selectedTown,
    this.address = '',
    this.openTime,
    this.closeTime,
    this.selectedLocation,
    this.photoFiles = const [],
    this.ownerName = '',
    this.phoneNumber = '',
    this.documentFile,
    this.isKVKKChecked = false,
    this.isCommentEnabled = true,
    this.isSubmitting = false,
    this.isError = false,
  });

  final StoreModel? selectedCompany;
  final MerchantApplicationStep currentStep;
  final bool isNewCompanyMode;

  final String companyName;
  final String companyDescription;
  final CategoryModel? selectedCategory;
  final RegionalCityModel? selectedCity;
  final List<RegionalTownSubItem> townItems;
  final RegionalTownSubItem? selectedTown;

  final String address;
  final TimeOfDay? openTime;
  final TimeOfDay? closeTime;
  final LatLng? selectedLocation;
  final List<File> photoFiles;

  final String ownerName;
  final String phoneNumber;
  final File? documentFile;
  final bool isKVKKChecked;
  final bool isCommentEnabled;

  final bool isSubmitting;
  final bool isError;

  static int get stepCount => MerchantApplicationStep.values.length;
  bool get isFirstStep => currentStep == MerchantApplicationStep.values.first;
  bool get isLastStep => currentStep == MerchantApplicationStep.values.last;

  @override
  List<Object?> get props => [
    selectedCompany,
    currentStep,
    isNewCompanyMode,
    companyName,
    companyDescription,
    selectedCategory,
    selectedCity,
    townItems,
    selectedTown,
    address,
    openTime,
    closeTime,
    selectedLocation,
    photoFiles,
    ownerName,
    phoneNumber,
    documentFile,
    isKVKKChecked,
    isCommentEnabled,
    isSubmitting,
    isError,
  ];

  MerchantApplicationState copyWith({
    StoreModel? selectedCompany,
    bool clearSelectedCompany = false,
    MerchantApplicationStep? currentStep,
    bool? isNewCompanyMode,
    String? companyName,
    String? companyDescription,
    CategoryModel? selectedCategory,
    bool clearSelectedCategory = false,
    RegionalCityModel? selectedCity,
    List<RegionalTownSubItem>? townItems,
    RegionalTownSubItem? selectedTown,
    bool clearSelectedTown = false,
    String? address,
    TimeOfDay? openTime,
    bool clearOpenTime = false,
    TimeOfDay? closeTime,
    bool clearCloseTime = false,
    LatLng? selectedLocation,
    bool clearSelectedLocation = false,
    List<File>? photoFiles,
    String? ownerName,
    String? phoneNumber,
    File? documentFile,
    bool clearDocumentFile = false,
    bool? isKVKKChecked,
    bool? isCommentEnabled,
    bool? isSubmitting,
    bool? isError,
  }) => MerchantApplicationState(
    selectedCompany: clearSelectedCompany
        ? null
        : (selectedCompany ?? this.selectedCompany),
    currentStep: currentStep ?? this.currentStep,
    isNewCompanyMode: isNewCompanyMode ?? this.isNewCompanyMode,
    companyName: companyName ?? this.companyName,
    companyDescription: companyDescription ?? this.companyDescription,
    selectedCategory: clearSelectedCategory
        ? null
        : (selectedCategory ?? this.selectedCategory),
    selectedCity: selectedCity ?? this.selectedCity,
    townItems: townItems ?? this.townItems,
    selectedTown: clearSelectedTown
        ? null
        : (selectedTown ?? this.selectedTown),
    address: address ?? this.address,
    openTime: clearOpenTime ? null : (openTime ?? this.openTime),
    closeTime: clearCloseTime ? null : (closeTime ?? this.closeTime),
    selectedLocation: clearSelectedLocation
        ? null
        : (selectedLocation ?? this.selectedLocation),
    photoFiles: photoFiles ?? this.photoFiles,
    ownerName: ownerName ?? this.ownerName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    documentFile: clearDocumentFile
        ? null
        : (documentFile ?? this.documentFile),
    isKVKKChecked: isKVKKChecked ?? this.isKVKKChecked,
    isCommentEnabled: isCommentEnabled ?? this.isCommentEnabled,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    isError: isError ?? this.isError,
  );
}
