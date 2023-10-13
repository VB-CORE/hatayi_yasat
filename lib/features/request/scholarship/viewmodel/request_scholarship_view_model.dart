import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/request/scholarship/model/request_scholarship_model.dart';
import 'package:vbaseproject/features/request/scholarship/request_scholarship_state.dart';

class RequestScholarshipViewModel
    extends StateNotifier<RequestScholarshipState> {
  RequestScholarshipViewModel() : super(const RequestScholarshipState());

  void changePolicyCheck({required bool value}) {
    state = state.copyWith(isPolicyChecked: value);
  }

  void changeLoading({required bool value}) {
    state = state.copyWith(isLoading: value);
  }

  void updateModel(RequestScholarshipModel model) {
    state = state.copyWith(requestScholarshipModel: model);
  }

  Future<String?> uploadStudentDocumentPDF() async {
    // fake upload logic until add upload file in life_shared
    await Future<void>.delayed(const Duration(seconds: 2));
    return null;
  }

  Future<bool> uploadScholarship() async {
    final pdfPath = await uploadStudentDocumentPDF();
    if (pdfPath.ext.isNullOrEmpty) return false;
    // create custom model for store firebase firestore
    // upload model to firebase firestore
    // return isOkay state
    return true;
  }
}
