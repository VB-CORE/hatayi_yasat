import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/index.dart';
import 'package:lifeclient/core/service/analytics/model/analytics_event.dart';
import 'package:lifeclient/features/sub_feature/forms/project_request/provider/project_request_state.dart';
import 'package:lifeclient/product/model/request_project_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'project_request_provider.g.dart';

@riverpod
final class ProjectRequestProvider extends _$ProjectRequestProvider
    with ProjectDependencyMixin {
  @override
  ProjectRequestState build() => const ProjectRequestState();

  Future<bool> addNewDataToService(
    RequestProjectModel requestProjectModel,
  ) async {
    state = state.copyWith(
      requestProjectModel: requestProjectModel,
      isSendingRequest: true,
    );

    final uuid = const Uuid().v4();
    final bytes = await requestProjectModel.imageFile.readAsBytes();
    final uploadResponse = await storageService.uploadImage(
      fileBytes: bytes,
      root: RootStorageName.pending,
      key: uuid,
    );
    final uploadImage = uploadResponse.dataOrNull;
    if (uploadImage == null) return _failed('image_upload');

    final modelStorage = CampaignModel(
      name: requestProjectModel.projectName,
      topic: requestProjectModel.projectTopic,
      description: requestProjectModel.projectDescription,
      publisher: requestProjectModel.publisher,
      phone: requestProjectModel.phone,
      expireDate: requestProjectModel.expireDate,
      coverPhoto: uploadImage,
      isApproved: false,
    );

    final response = await firestoreService.add<CampaignModel>(
      model: modelStorage,
      path: CollectionPaths.unApprovedCampaigns,
    );

    state = state.copyWith(
      isSendingRequest: false,
    );

    switch (response) {
      case FirebaseSuccess<String, FirestoreError>():
        analyticsService.logEvent(
          AnalyticsEvent.formSubmit,
          parameters: {
            AnalyticsParameter.formType: AnalyticsFormType.projectRequest.key,
          },
        );
        return true;
      case FirebaseFailure<String, FirestoreError>():
        return _failed('write_failed');
    }
  }

  bool _failed(String reason) {
    analyticsService.logEvent(
      AnalyticsEvent.formError,
      parameters: {
        AnalyticsParameter.formType: AnalyticsFormType.projectRequest.key,
        AnalyticsParameter.reason: reason,
      },
    );
    return false;
  }
}
