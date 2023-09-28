import 'package:firebase_storage/firebase_storage.dart';
import 'package:life_shared/life_shared.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:vbaseproject/features/request/project/model/request_project_model.dart';
import 'package:vbaseproject/features/request/project/request_project_state.dart';
import 'package:vbaseproject/product/init/firebase_custom_service.dart';

class RequestProjectViewModel extends StateNotifier<RequestProjectState> {
  RequestProjectViewModel()
      : super(const RequestProjectState(isSendingRequest: false));

  void changeLoading() {
    state = state.copyWith(isSendingRequest: !state.isSendingRequest);
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
      startDate: requestProjectModel.startDate,
      endDate: requestProjectModel.endDate,
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
