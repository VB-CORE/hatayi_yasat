import 'package:life_shared/life_shared.dart';
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
    final companies = await ref
        .read(merchantApplicationServiceProvider)
        .fetchCompanies();
    state = state.copyWith(companies: companies, isFetching: false);
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

  void selectCompany(StoreModel company) {
    state = state.copyWith(selectedCompany: company);
  }

  void clearSelectedCompany() {
    state = state.copyWith(clearSelectedCompany: true);
  }

  Future<bool> submit(MerchantApplicationModel model) async {
    state = state.copyWith(isSubmitting: true, isError: false);
    final response = await ref
        .read(merchantApplicationServiceProvider)
        .submit(model);
    state = state.copyWith(isSubmitting: false, isError: !response);
    return response;
  }
}
