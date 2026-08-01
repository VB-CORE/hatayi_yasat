import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart' hide MerchantShowcaseModuleModel, MerchantShowcaseType;
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_showcase_model.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_showcase_module_model.dart';
import 'package:lifeclient/features/merchant_panel/provider/merchant_showcase_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'merchant_showcase_view_model.g.dart';

@riverpod
final class MerchantShowcaseViewModel extends _$MerchantShowcaseViewModel
    with ProjectDependencyMixin {
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

  Future<bool> upsert(MerchantShowcaseModuleModel module) {
    final modules = [...state.modules];
    final index = modules.indexWhere((item) => item.id == module.id);
    if (index == -1) {
      modules.add(module);
    } else {
      modules[index] = module;
    }
    return _persist(modules);
  }

  Future<bool> remove(String moduleId) {
    final modules = state.modules
        .where((module) => module.id != moduleId)
        .toList();
    return _persist(modules);
  }

  Future<bool> toggleActive(MerchantShowcaseModuleModel module) =>
      upsert(module.copyWith(isActive: !module.isActive));

  Future<bool> reorder(int oldIndex, int newIndex) {
    final modules = [...state.modules];
    if (oldIndex >= modules.length) return Future.value(false);
    final module = modules.removeAt(oldIndex);
    modules.insert(newIndex.clamp(0, modules.length), module);
    return _persist(modules);
  }

  Future<String?> uploadImage(File file) async {
    final result = await storageService.uploadImage(
      fileBytes: await file.readAsBytes(),
      root: RootStorageName.approvedApplications,
      key: createModuleId(),
    );
    return result.dataOrNull;
  }

  Future<bool> _persist(List<MerchantShowcaseModuleModel> modules) async {
    final previous = state.modules;
    final ordered = [
      for (final (index, module) in modules.indexed)
        module.copyWith(order: index),
    ];
    state = state.copyWith(modules: ordered, isSaving: true, isError: false);

    final result = await firestoreService.updateFields(
      path: CollectionPaths.approvedApplications,
      documentId: storeId,
      fields: {
        MerchantShowcaseModel.fieldName: ordered
            .map((module) => module.toJson())
            .toList(),
        FirestoreFields.updatedAt.name: FieldValue.serverTimestamp(),
      },
    );

    if (!result.isSuccess) {
      state = state.copyWith(modules: previous, isSaving: false, isError: true);
      return false;
    }

    state = state.copyWith(isSaving: false);
    return true;
  }

  Future<void> _fetch() async {
    final result = await firestoreService.getSingleData<MerchantShowcaseModel>(
      model: const MerchantShowcaseModel(),
      path: CollectionPaths.approvedApplications,
      id: storeId,
    );

    state = switch (result) {
      FirebaseSuccess(:final data) => state.copyWith(
        modules: data?.modules ?? const [],
        isFetching: false,
        isError: false,
      ),
      FirebaseFailure() => state.copyWith(isFetching: false, isError: true),
    };
  }
}
