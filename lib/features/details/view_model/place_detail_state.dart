import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';

@immutable
final class PlaceDetailState extends Equatable {
  const PlaceDetailState({required this.storeModel, this.isFetching = false});

  final StoreModel storeModel;
  final bool isFetching;
  @override
  List<Object?> get props => [
        storeModel,
      ];

  PlaceDetailState copyWith({
    StoreModel? storeModel,
    bool? isFetching,
  }) {
    return PlaceDetailState(
      storeModel: storeModel ?? this.storeModel,
      isFetching: isFetching ?? this.isFetching,
    );
  }
}
