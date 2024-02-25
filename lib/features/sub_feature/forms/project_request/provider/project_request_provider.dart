import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/forms/project_request/provider/project_request_state.dart';
import 'package:lifeclient/product/init/firebase_custom_service.dart';
import 'package:lifeclient/product/model/request_project_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'project_request_provider.g.dart';

@riverpod
final class ProjectRequestProvider extends _$ProjectRequestProvider {
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
    final uploadImage = await FirebaseStorageService().uploadImage(
      fileBytes: bytes,
      root: RootStorageName.pending,
      key: uuid,
    );

    if (uploadImage == null) return false;

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

    state = state.copyWith(
      isSendingRequest: false,
    );

    if (response == null) return false;

    return true;
  }
}
