import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/model/place_request_model.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/provider/place_request_state.dart';

part 'place_request_provider.g.dart';

@riverpod
final class PlaceRequestProvider extends _$PlaceRequestProvider {
  @override
  PlaceRequestState build() => const PlaceRequestState();

  Future<bool> addNewDataToService(
    PlaceRequestModel placeRequestModel,
  ) async {
    state = state.copyWith(
      placeRequestModel: placeRequestModel,
      isSendingRequest: true,
    );

    final uuid = const Uuid().v4();
    final bytes = await placeRequestModel.imageFile.readAsBytes();
    final uploadImage = await FirebaseStorageService().uploadImage(
      fileBytes: bytes,
      root: RootStorageName.pending,
      key: uuid,
    );

    if (uploadImage == null) return false;
    final storage = StoreModel(
      category: placeRequestModel.placeCategory,
      name: placeRequestModel.placeName,
      description: placeRequestModel.placeDescription,
      owner: placeRequestModel.placeOwnerName,
      address: placeRequestModel.placeAddress,
      phone: placeRequestModel.placePhoneNumber.ext.phoneFormatValue,
      images: [uploadImage],
      townCode: placeRequestModel.placeDistrict.code ?? 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isApproved: false,
      // TODO: Get deviceId
      deviceID: '',
    );

    final response = await FirebaseService().add<StoreModel>(
      model: storage,
      path: CollectionPaths.unApprovedApplications,
    );

    state = state.copyWith(
      isSendingRequest: false,
    );

    if (response == null) {
      return false;
    }

    return true;
  }
}
