import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vbaseproject/features/v2/sub_feature/forms/view/model/place_request_model.dart';

@immutable
final class PlaceDetailState extends Equatable {
  const PlaceDetailState();
  @override
  List<Object?> get props => [];

  PlaceDetailState copyWith({
    PlaceRequestModel? placeRequestModel,
  }) {
    return const PlaceDetailState();
  }
}
