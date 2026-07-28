import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_showcase_module_model.dart';

final class MerchantShowcaseState extends Equatable {
  const MerchantShowcaseState({
    this.modules = const [],
    this.isFetching = false,
    this.isError = false,
    this.isSaving = false,
    this.isPreview = false,
  });

  final List<MerchantShowcaseModuleModel> modules;
  final bool isFetching;
  final bool isError;
  final bool isSaving;

  final bool isPreview;

  List<MerchantShowcaseModuleModel> get publishedModules =>
      modules.where((module) => module.isPublished).toList();

  MerchantShowcaseState copyWith({
    List<MerchantShowcaseModuleModel>? modules,
    bool? isFetching,
    bool? isError,
    bool? isSaving,
    bool? isPreview,
  }) {
    return MerchantShowcaseState(
      modules: modules ?? this.modules,
      isFetching: isFetching ?? this.isFetching,
      isError: isError ?? this.isError,
      isSaving: isSaving ?? this.isSaving,
      isPreview: isPreview ?? this.isPreview,
    );
  }

  @override
  List<Object?> get props => [
    modules,
    isFetching,
    isError,
    isSaving,
    isPreview,
  ];
}
