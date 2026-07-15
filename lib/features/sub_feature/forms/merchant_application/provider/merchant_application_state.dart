import 'package:equatable/equatable.dart';
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

final class MerchantApplicationState extends Equatable {
  const MerchantApplicationState({
    this.companies = const [],
    this.selectedCompany,
    this.currentStep = MerchantApplicationStep.company,
    this.isFetching = false,
    this.isSubmitting = false,
    this.isError = false,
  });

  final List<StoreModel> companies;
  final StoreModel? selectedCompany;
  final MerchantApplicationStep currentStep;
  final bool isFetching;
  final bool isSubmitting;
  final bool isError;

  static int get stepCount => MerchantApplicationStep.values.length;
  bool get isFirstStep => currentStep == MerchantApplicationStep.values.first;
  bool get isLastStep => currentStep == MerchantApplicationStep.values.last;

  @override
  List<Object?> get props => [
    companies,
    selectedCompany,
    currentStep,
    isFetching,
    isSubmitting,
    isError,
  ];

  MerchantApplicationState copyWith({
    List<StoreModel>? companies,
    StoreModel? selectedCompany,
    bool clearSelectedCompany = false,
    MerchantApplicationStep? currentStep,
    bool? isFetching,
    bool? isSubmitting,
    bool? isError,
  }) => MerchantApplicationState(
    companies: companies ?? this.companies,
    selectedCompany: clearSelectedCompany
        ? null
        : (selectedCompany ?? this.selectedCompany),
    currentStep: currentStep ?? this.currentStep,
    isFetching: isFetching ?? this.isFetching,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    isError: isError ?? this.isError,
  );
}
