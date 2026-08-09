import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/chain_store/provider/chain_store_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chain_store_provider.g.dart';

@riverpod
final class ChainStoreProvider extends _$ChainStoreProvider
    with ProjectDependencyMixin {
  @override
  ChainStoreState build() {
    unawaited(fetchMarkets());

    return const ChainStoreState();
  }

  CollectionReference<ChainStoreModel?> fetchChainStoreCollectionReference() {
    return firestoreService.collectionReference(
      CollectionPaths.chainStores,
      ChainStoreModel.empty(),
    );
  }

  Future<void> fetchMarkets() async {
    final result = await firestoreService.getList<ChainStoreModel>(
      model: ChainStoreModel.empty(),
      path: CollectionPaths.chainStores,
    );

    state = switch (result) {
      FirebaseSuccess(:final data) => state.copyWith(
        chainStores: data,
        isFetching: false,
      ),
      FirebaseFailure() => state.copyWith(isFetching: false, isError: true),
    };
  }
}
