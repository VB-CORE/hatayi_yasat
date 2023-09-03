import 'package:kartal/kartal.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:vbaseproject/features/request/company/modal/request_company_modal.dart';
import 'package:vbaseproject/features/request/company/request_state.dart';

import 'package:vbaseproject/product/model/firebase/store_model.dart';

import 'package:vbaseproject/product/service/firebase_service.dart';

import 'package:vbaseproject/product/utility/firebase/collection_enums.dart';

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

    final uploadImage = await FirebaseService.uploadImage(
      file: requestCompanyModel.imageFile,
      root: RootStorageName.company,
      key: uuid,
    );
    if (uploadImage == null) return false;
    final storage = StoreModel(
      name: requestCompanyModel.companyName,
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

    final response = await FirebaseService.add<StoreModel>(
      model: storage,
      path: CollectionEnums.unApprovedApplications,
    );

    if (response == null) {
      state = state.copyWith(
        isSendingRequest: false,
        isServiceError: true,
      );
      return false;
    }

    return true;
  }
}
