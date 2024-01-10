import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vbaseproject/features/sub_feature/forms/provider/scholarship_request_state.dart';
import 'package:vbaseproject/product/model/request_scholarship_model.dart';

part 'scholarship_request_provider.g.dart';

@riverpod
final class ScholarshipRequestProvider extends _$ScholarshipRequestProvider {
  @override
  ScholarshipRequestState build() => const ScholarshipRequestState();

  void updateRequestModel(RequestScholarshipModel model) {
    state = state.copyWith(scholarshipModel: model);
  }
}
