import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:life_shared/life_shared.dart';

@immutable
final class ChainStoreState extends Equatable {
  const ChainStoreState({
    this.chainStores = const [],
    this.isFetching = true,
    this.isError = false,
  });

  final List<ChainStoreModel> chainStores;
  final bool isFetching;
  final bool isError;

  ChainStoreModel? marketById(String documentId) =>
      chainStores.firstWhereOrNull((market) => market.documentId == documentId);

  int get totalShopCount => chainStores.fold(
    0,
    (total, market) => total + (market.branches?.length ?? 0),
  );

  @override
  List<Object?> get props => [chainStores, isFetching, isError];

  ChainStoreState copyWith({
    List<ChainStoreModel>? chainStores,
    bool? isFetching,
    bool? isError,
  }) {
    return ChainStoreState(
      chainStores: chainStores ?? this.chainStores,
      isFetching: isFetching ?? this.isFetching,
      isError: isError ?? this.isError,
    );
  }
}
