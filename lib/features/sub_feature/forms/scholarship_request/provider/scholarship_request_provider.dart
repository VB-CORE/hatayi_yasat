import 'package:easy_localization/easy_localization.dart';
import 'package:life_shared/life_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:vbaseproject/features/sub_feature/forms/scholarship_request/provider/scholarship_request_state.dart';
import 'package:vbaseproject/product/feature/cache/shared_cache.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/request_scholarship_model.dart';
import 'package:vbaseproject/product/utility/constants/app_constants.dart';

part 'scholarship_request_provider.g.dart';

@riverpod
final class ScholarshipRequestProvider extends _$ScholarshipRequestProvider {
  @override
  ScholarshipRequestState build() => const ScholarshipRequestState();

  final SharedCache _sharedCache = SharedCache.instance;

  void initializeForCanApply() {
    state = state.copyWith(canApply: true);
    final lastApplyDate = _sharedCache.getApplyScholarshipTime();
    if (lastApplyDate == null) return;
    if (DateTime.now().difference(lastApplyDate).inDays < AppConstants.kOne) {
      state = state.copyWith(canApply: false);
      return;
    }
  }

  Future<(String?, UploadErrors?)> uploadStudentDocumentPDF() async {
    final file = state.scholarshipModel?.studentDocument;
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

  Future<String?> uploadScholarship(
    RequestScholarshipModel requestScholarshipModel,
  ) async {
    state = state.copyWith(
      scholarshipModel: requestScholarshipModel,
      isSendingRequest: true,
    );
    final model = state.scholarshipModel;
    if (model == null) {
      return LocaleKeys.requestScholarship_error_undefinedError.tr();
    }
    final (pdfLinkKey, errorType) = await uploadStudentDocumentPDF();
    if (errorType != null) return errorType.errorMessage;
    if (pdfLinkKey == null) return null;
    final scholarshipModel = ScholarshipModel(
      email: model.email,
      phoneNumber: model.phoneNumber,
      story: model.story,
      studentDocument: '',
      documentFileRef: pdfLinkKey,
    );

    final response = await FirebaseService().add<ScholarshipModel>(
      model: scholarshipModel,
      path: CollectionPaths.scholarship,
    );

    state = state.copyWith(
      isSendingRequest: false,
    );

    if (response == null) {
      return LocaleKeys.requestScholarship_error_undefinedError.tr();
    }
    await _sharedCache.saveApplyScholarshipTime();
    return null;
  }
}

extension UploadErrorsExtension on UploadErrors {
  String get errorMessage {
    switch (this) {
      case UploadErrors.sizeLimit:
        return LocaleKeys.requestScholarship_error_fileSizeError.tr();
      case UploadErrors.service:
        return LocaleKeys.requestScholarship_error_undefinedError.tr();
      case UploadErrors.noFile:
        return LocaleKeys.requestScholarship_error_noFileError.tr();
    }
  }
}
