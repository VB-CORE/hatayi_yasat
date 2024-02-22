import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';

@immutable
final class PlaceDetailState extends Equatable {
  const PlaceDetailState({
    required this.storeModel,
    this.isFetching = false,
    this.isError = false,
  });

  final StoreModel storeModel;
  final bool isFetching;
  final bool isError;
  @override
  List<Object?> get props => [
        storeModel,
        isFetching,
        isError,
      ];

  PlaceDetailState copyWith({
    StoreModel? storeModel,
    bool? isFetching,
    bool? isError,
  }) {
    return PlaceDetailState(
      storeModel: storeModel ?? this.storeModel,
      isFetching: isFetching ?? this.isFetching,
      isError: isError ?? this.isError,
    );
  }
}
