import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:uuid/uuid.dart';
import 'package:vbaseproject/features/request/scholarship/model/request_scholarship_model.dart';
import 'package:vbaseproject/features/request/scholarship/request_scholarship_state.dart';
import 'package:vbaseproject/product/feature/cache/shared_cache.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/index.dart';

final class RequestScholarshipViewModel
    extends StateNotifier<RequestScholarshipState> {
  RequestScholarshipViewModel() : super(const RequestScholarshipState());

  final SharedCache _sharedCache = SharedCache.instance;

  void initializeForCanApply() {
    final lastApplyDate = _sharedCache.getApplyScholarshipTime();
    if (lastApplyDate == null) return;
    if (lastApplyDate.difference(DateTime.now()).inDays < AppConstants.kOne) {
      state = state.copyWith(canApply: false);
    }
  }

  void changePolicyCheck({required bool value}) {
    state = state.copyWith(isPolicyChecked: value);
  }

  void changeLoading({required bool value}) {
    state = state.copyWith(isLoading: value);
  }

  void updateModel(RequestScholarshipModel model) {
    state = state.copyWith(requestScholarshipModel: model);
  }

  Future<(String?, UploadErrors?)> uploadStudentDocumentPDF() async {
    final file = state.requestScholarshipModel?.studentDocument;
    if (file == null) return (null, UploadErrors.noFile);
    final uuid = const Uuid().v4();
    final resultFileLink = await FirebaseStorageService().uploadFile(
      root: RootStorageName.scholarship,
      key: uuid,
      file: file,
      size: FileSizes.small,
    );
    return resultFileLink;
  }

  Future<String?> uploadScholarship() async {
    final model = state.requestScholarshipModel;
    if (model == null) {
      return LocaleKeys.request_scholarship_error_undefined_error.tr();
    }
    final (pdfLink, errorType) = await uploadStudentDocumentPDF();
    if (errorType != null) return errorType.errorMessage;
    final scholarshipModel = ScholarshipModel(
      email: model.email,
      phoneNumber: model.phoneNumber,
      story: model.story,
      studentDocument: pdfLink!,
    );

    final response = await FirebaseService().add<ScholarshipModel>(
      model: scholarshipModel,
      path: CollectionPaths.scholarship,
    );

    if (response == null) {
      return LocaleKeys.request_scholarship_error_undefined_error.tr();
    }

    await _sharedCache.saveApplyScholarshipTime();
    return null;
  }
}

extension UploadErrorsExtension on UploadErrors {
  String get errorMessage {
    switch (this) {
      case UploadErrors.sizeLimit:
        return LocaleKeys.request_scholarship_error_file_size_error.tr();
      case UploadErrors.service:
        return LocaleKeys.request_scholarship_error_undefined_error.tr();
      case UploadErrors.noFile:
        return LocaleKeys.request_scholarship_error_no_file_error.tr();
    }
  }
}
