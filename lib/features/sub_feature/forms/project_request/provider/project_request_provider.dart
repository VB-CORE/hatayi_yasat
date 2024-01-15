import 'package:life_shared/life_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:vbaseproject/features/sub_feature/forms/project_request/provider/project_request_state.dart';
import 'package:vbaseproject/product/init/firebase_custom_service.dart';
import 'package:vbaseproject/product/model/request_project_model.dart';

part 'project_request_provider.g.dart';

@riverpod
final class ProjectRequestProvider extends _$ProjectRequestProvider {
  @override
  ProjectRequestState build() => const ProjectRequestState();

  void changeLoading() {
    state =
        state.copyWith(isSendingRequest: !(state.isSendingRequest ?? false));
  }

  Future<bool> addNewDataToService(
    RequestProjectModel requestProjectModel,
  ) async {
    state = state.copyWith(
      requestProjectModel: requestProjectModel,
      isSendingRequest: true,
    );
    final uuid = const Uuid().v4();

    final bytes = await requestProjectModel.imageFile.readAsBytes();
    final uploadImage = await FirebaseStorageService().uploadImage(
      fileBytes: bytes,
      root: RootStorageName.pending,
      key: uuid,
    );

    if (uploadImage == null) return _resetWithError();

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

    final response = await FirebaseCustomService().add<CampaignModel>(
      model: modelStorage,
      path: CollectionPaths.unApprovedCampaigns,
    );

    if (response == null) return _resetWithError();

    state = state.copyWith(
      isSendingRequest: false,
      isServiceError: false,
    );

    return true;
  }

  bool _resetWithError() {
    state = state.copyWith(
      isSendingRequest: false,
      isServiceError: true,
    );
    return false;
  }
}
