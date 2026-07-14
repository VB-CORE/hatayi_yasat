import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_application_model.dart';

final class MerchantApplicationState extends Equatable {
  const MerchantApplicationState({
    this.model,
    this.companies = const [],
    this.currentStep = 0,
    this.isFetching = false,
    this.isSubmitting = false,
    this.isError = false,
  });

  final MerchantApplicationModel? model;
  final List<StoreModel> companies;
  final int currentStep;
  final bool isFetching;
  final bool isSubmitting;
  final bool isError;

  static const stepCount = 2;

  bool get isFirstStep => currentStep == 0;
  bool get isLastStep => currentStep == stepCount - 1;

  @override
  List<Object?> get props => [
    model,
    companies,
    currentStep,
    isFetching,
    isSubmitting,
    isError,
  ];

  MerchantApplicationState copyWith({
    MerchantApplicationModel? model,
    List<StoreModel>? companies,
    int? currentStep,
    bool? isFetching,
    bool? isSubmitting,
    bool? isError,
  }) => MerchantApplicationState(
    model: model ?? this.model,
    companies: companies ?? this.companies,
    currentStep: currentStep ?? this.currentStep,
    isFetching: isFetching ?? this.isFetching,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    isError: isError ?? this.isError,
  );
}
