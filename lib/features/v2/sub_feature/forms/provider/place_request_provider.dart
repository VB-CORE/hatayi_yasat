import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vbaseproject/features/v2/sub_feature/forms/provider/place_request_state.dart';
import 'package:vbaseproject/features/v2/sub_feature/forms/view/model/place_request_model.dart';

part 'place_request_provider.g.dart';

@riverpod
final class PlaceRequestProvider extends _$PlaceRequestProvider {
  @override
  PlaceRequestState build() => const PlaceRequestState();

  void updateRequestModel(PlaceRequestModel model) {
    state = state.copyWith(placeRequestModel: model);
  }
}
