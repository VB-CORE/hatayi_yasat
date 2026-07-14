import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/model/merchant_application_model.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/provider/merchant_application_service_provider.dart';
import 'package:lifeclient/features/sub_feature/forms/merchant_application/provider/merchant_application_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'merchant_application_view_model.g.dart';

@riverpod
final class MerchantApplicationViewModel extends _$MerchantApplicationViewModel
    with ProjectDependencyMixin {
  @override
  MerchantApplicationState build() => const MerchantApplicationState();

  Future<void> loadCompanies() async {
    state = state.copyWith(isFetching: true);
    try {
      final companies = await ref
          .read(merchantApplicationServiceProvider)
          .fetchCompanies();
      state = state.copyWith(companies: companies, isError: false);
    } catch (_) {
      state = state.copyWith(isError: true);
    } finally {
      state = state.copyWith(isFetching: false);
    }
  }

  void nextStep() {
    if (state.isLastStep) return;
    state = state.copyWith(currentStep: state.currentStep + 1);
  }

  void previousStep() {
    if (state.isFirstStep) return;
    state = state.copyWith(currentStep: state.currentStep - 1);
  }

  Future<bool> submit(MerchantApplicationModel model) async {
    state = state.copyWith(
      model: model,
      isSubmitting: true,
      isError: false,
    );
    try {
      final response = await ref
          .read(merchantApplicationServiceProvider)
          .submit(model);
      state = state.copyWith(isError: !response);
      return response;
    } catch (_) {
      state = state.copyWith(isError: true);
      return false;
    } finally {
      state = state.copyWith(isSubmitting: false);
    }
  }
}
