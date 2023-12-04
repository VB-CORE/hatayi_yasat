import 'package:equatable/equatable.dart';
import 'package:vbaseproject/features/v2/sub_feature/forms/view/model/place_request_model.dart';

final class PlaceRequestState extends Equatable {
  const PlaceRequestState({
    this.placeRequestModel,
  });
  final PlaceRequestModel? placeRequestModel;
  @override
  List<Object?> get props => [placeRequestModel];

  PlaceRequestState copyWith({
    PlaceRequestModel? placeRequestModel,
  }) {
    return PlaceRequestState(
      placeRequestModel: placeRequestModel ?? this.placeRequestModel,
    );
  }
}
