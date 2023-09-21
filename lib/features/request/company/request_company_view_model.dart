import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:vbaseproject/features/request/company/modal/request_company_modal.dart';
import 'package:vbaseproject/features/request/company/request_state.dart';

class RequestCompanyViewModel extends StateNotifier<RequestCompanyState> {
  RequestCompanyViewModel(this.deviceId) : super(const RequestCompanyState());

  final String deviceId;

  void changeLoading() {
    state =
        state.copyWith(isSendingRequest: !(state.isSendingRequest ?? false));
  }

  Future<bool> addNewDataToService(
    RequestCompanyModel requestCompanyModel,
  ) async {
    state = state.copyWith(
      requestCompanyModel: requestCompanyModel,
      isSendingRequest: true,
    );
    final uuid = const Uuid().v4();
    final bytes = await requestCompanyModel.imageFile.readAsBytes();
    final uploadImage = await FirebaseStorageService().uploadImage(
      fileBytes: bytes,
      root: RootStorageName.pending,
      key: uuid,
    );

    if (uploadImage == null) return false;
    final storage = StoreModel(
      name: requestCompanyModel.companyName,
      description: requestCompanyModel.companyDescription,
      owner: requestCompanyModel.nameSurname,
      address: requestCompanyModel.address,
      phone: requestCompanyModel.phone.ext.phoneFormatValue,
      images: [uploadImage],
      townCode: requestCompanyModel.town.code ?? 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isApproved: false,
      deviceID: deviceId,
    );

    final response = await FirebaseService().add<StoreModel>(
      model: storage,
      path: CollectionPaths.unApprovedApplications,
    );

    if (response == null) {
      state = state.copyWith(
        isSendingRequest: false,
        isServiceError: true,
      );
      return false;
    }

    state = state.copyWith(
      isSendingRequest: false,
      isServiceError: true,
    );

    return true;
  }
}
