import 'package:easy_localization/easy_localization.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_event.dart';
import 'package:lifeclient/features/sub_feature/forms/scholarship_request/provider/scholarship_request_state.dart';
import 'package:lifeclient/product/feature/cache/shared_operation/shared_cache.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/request_scholarship_model.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'scholarship_request_provider.g.dart';

@riverpod
final class ScholarshipRequestProvider extends _$ScholarshipRequestProvider
    with ProjectDependencyMixin {
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

  Future<StorageResult<String>> uploadStudentDocumentPDF() {
    final file = state.scholarshipModel?.studentDocument;
    if (file == null) {
      return Future.value(
        const FirebaseFailure<String, StorageError>(StorageError.noFile),
      );
    }

    return storageService.uploadFile(
      root: RootStorageName.scholarship,
      key: const Uuid().v4(),
      file: file,
      size: FileSizes.small,
    );
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

    final String documentFileRef;
    switch (await uploadStudentDocumentPDF()) {
      case FirebaseFailure(:final error):
        state = state.copyWith(
          isSendingRequest: false,
        );

        _logError(error.name);
        return error.errorMessage;
      case FirebaseSuccess(:final data):
        documentFileRef = data;
    }

    final scholarshipModel = ScholarshipModel(
      email: model.email,
      phoneNumber: model.phoneNumber,
      story: model.story,
      studentDocument: '',
      documentFileRef: documentFileRef,
    );

    final response = await firestoreService.add<ScholarshipModel>(
      model: scholarshipModel,
      path: CollectionPaths.scholarship,
    );

    state = state.copyWith(
      isSendingRequest: false,
    );

    if (!response.isSuccess) {
      _logError('write_failed');
      return LocaleKeys.requestScholarship_error_undefinedError.tr();
    }
    await _sharedCache.saveApplyScholarshipTime();
    analyticsService.logEvent(
      AnalyticsEvent.formSubmit,
      parameters: {
        AnalyticsParameter.formType: AnalyticsFormType.scholarshipRequest.key,
      },
    );
    return null;
  }

  void _logError(String reason) {
    analyticsService.logEvent(
      AnalyticsEvent.formError,
      parameters: {
        AnalyticsParameter.formType: AnalyticsFormType.scholarshipRequest.key,
        AnalyticsParameter.reason: reason,
      },
    );
  }
}

extension on StorageError {
  String get errorMessage => switch (this) {
    StorageError.sizeLimit =>
      LocaleKeys.requestScholarship_error_fileSizeError.tr(),
    StorageError.noFile => LocaleKeys.requestScholarship_error_noFileError.tr(),
    _ => LocaleKeys.requestScholarship_error_undefinedError.tr(),
  };
}
