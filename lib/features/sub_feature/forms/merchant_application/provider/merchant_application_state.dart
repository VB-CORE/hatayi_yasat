import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_application_step.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_photo.dart';

final class MerchantApplicationState extends Equatable {
  const MerchantApplicationState({
    this.selectedCompany,
    this.currentStep = MerchantApplicationStep.company,
    this.isNewCompanyMode = true,
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
    this.photos = const [],
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
  final List<MerchantPhoto> photos;
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

  bool get isCompanyLocked => !isNewCompanyMode && selectedCompany != null;

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
    photos,
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
    List<MerchantPhoto>? photos,
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
    photos: photos ?? this.photos,
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
