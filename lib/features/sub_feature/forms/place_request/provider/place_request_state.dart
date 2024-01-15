import 'package:equatable/equatable.dart';
import 'package:vbaseproject/features/sub_feature/forms/place_request/model/place_request_model.dart';

final class PlaceRequestState extends Equatable {
  const PlaceRequestState({
    this.placeRequestModel,
    this.isSendingRequest,
    this.isServiceError,
  });

  final PlaceRequestModel? placeRequestModel;
  final bool? isSendingRequest;
  final bool? isServiceError;

  @override
  List<Object?> get props => [
        placeRequestModel,
        isSendingRequest,
        isServiceError,
      ];

  PlaceRequestState copyWith({
    PlaceRequestModel? placeRequestModel,
    bool? isSendingRequest,
    bool? isServiceError,
  }) {
    return PlaceRequestState(
      placeRequestModel: placeRequestModel ?? this.placeRequestModel,
      isSendingRequest: isSendingRequest ?? this.isSendingRequest,
      isServiceError: isServiceError ?? this.isServiceError,
    );
  }
}
