import 'package:equatable/equatable.dart';
import 'package:lifeclient/features/sub_feature/forms/place_request/model/place_request_model.dart';

final class PlaceRequestState extends Equatable {
  const PlaceRequestState({
    this.placeRequestModel,
    this.isSendingRequest,
  });

  final PlaceRequestModel? placeRequestModel;
  final bool? isSendingRequest;

  @override
  List<Object?> get props => [
        placeRequestModel,
        isSendingRequest,
      ];

  PlaceRequestState copyWith({
    PlaceRequestModel? placeRequestModel,
    bool? isSendingRequest,
  }) {
    return PlaceRequestState(
      placeRequestModel: placeRequestModel ?? this.placeRequestModel,
      isSendingRequest: isSendingRequest ?? this.isSendingRequest,
    );
  }
}
