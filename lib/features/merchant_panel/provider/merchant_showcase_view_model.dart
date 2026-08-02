import 'dart:async';
import 'dart:io';

import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_showcase_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'merchant_showcase_view_model.g.dart';

@riverpod
final class MerchantShowcaseViewModel extends _$MerchantShowcaseViewModel
    with ProjectDependencyMixin {
  static const String _orderField = 'order';

  FirestoreCollectionPath get _showcase => CollectionPaths.approvedApplications
      .sub(storeId, SubCollectionPaths.showcase);

  @override
  MerchantShowcaseState build(String storeId) {
    unawaited(_fetch());
    return const MerchantShowcaseState(isFetching: true);
  }

  String createModuleId() => const Uuid().v4();

  bool isFileSizeValid(File file) =>
      file.lengthSync() <= FileSizes.medium.toByte;

  void togglePreview() => state = state.copyWith(isPreview: !state.isPreview);

  Future<void> retry() async {
    state = state.copyWith(isFetching: true, isError: false);
    await _fetch();
  }

  Future<bool> upsert(MerchantShowcaseModuleModel module) async {
    final modules = [...state.modules];
    final index = modules.indexWhere((item) => item.id == module.id);
    final saved = index == -1 ? module.copyWith(order: modules.length) : module;
    if (index == -1) {
      modules.add(saved);
    } else {
      modules[index] = saved;
    }

    return _commit(modules, () async {
      final result = await firestoreService.insertWithID(
        path: _showcase,
        model: saved,
        key: saved.id,
      );
      return result.isSuccess;
    });
  }

  Future<bool> remove(String moduleId) async {
    final remaining = state.modules
        .where((module) => module.id != moduleId)
        .toList();
    final ordered = _withOrder(remaining);

    return _commit(ordered, () async {
      final result = await firestoreService.batchWrite((batch) {
        batch.update(
          _showcase.collection.doc(moduleId),
          SoftDelete.payload(),
        );
        for (final module in ordered) {
          batch.update(_showcase.collection.doc(module.id), {
            _orderField: module.order,
          });
        }
      });
      return result.isSuccess;
    });
  }

  Future<bool> toggleActive(MerchantShowcaseModuleModel module) =>
      upsert(module.copyWith(isActive: !module.isActive));

  Future<bool> reorder(int oldIndex, int newIndex) async {
    if (oldIndex >= state.modules.length) return false;

    final modules = [...state.modules];
    final module = modules.removeAt(oldIndex);
    modules.insert(newIndex.clamp(0, modules.length), module);
    final ordered = _withOrder(modules);

    return _commit(ordered, () async {
      final result = await firestoreService.batchWrite((batch) {
        for (final item in ordered) {
          batch.update(_showcase.collection.doc(item.id), {
            _orderField: item.order,
          });
        }
      });
      return result.isSuccess;
    });
  }

  Future<String?> uploadImage(File file) async {
    final result = await storageService.uploadImage(
      fileBytes: await file.readAsBytes(),
      root: RootStorageName.approvedApplications,
      key: createModuleId(),
    );
    return result.dataOrNull;
  }

  Future<bool> _commit(
    List<MerchantShowcaseModuleModel> next,
    Future<bool> Function() write,
  ) async {
    final previous = state.modules;
    state = state.copyWith(modules: next, isSaving: true, isError: false);
    final isSuccess = await write();
    state = isSuccess
        ? state.copyWith(isSaving: false)
        : state.copyWith(modules: previous, isSaving: false, isError: true);
    return isSuccess;
  }

  List<MerchantShowcaseModuleModel> _withOrder(
    List<MerchantShowcaseModuleModel> modules,
  ) => [
    for (final (index, module) in modules.indexed)
      module.copyWith(order: index),
  ];

  Future<void> _fetch() async {
    final result = await firestoreService.getList<MerchantShowcaseModuleModel>(
      model: const MerchantShowcaseModuleModel(),
      path: _showcase,
    );

    state = switch (result) {
      FirebaseSuccess(:final data) => state.copyWith(
        modules: data.where((module) => !module.isDeleted).toList()
          ..sort((a, b) => a.order.compareTo(b.order)),
        isFetching: false,
        isError: false,
      ),
      FirebaseFailure() => state.copyWith(isFetching: false, isError: true),
    };
  }
}
