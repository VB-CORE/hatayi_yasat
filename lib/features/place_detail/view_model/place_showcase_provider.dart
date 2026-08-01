import 'package:life_shared/life_shared.dart' hide MerchantShowcaseModuleModel, MerchantShowcaseType;
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_showcase_model.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_showcase_module_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'place_showcase_provider.g.dart';

final class PlaceShowcaseException implements Exception {
  const PlaceShowcaseException(this.error, this.message);

  final FirestoreError error;
  final String? message;

  @override
  String toString() => 'PlaceShowcaseException($error, $message)';
}

@riverpod
Future<List<MerchantShowcaseModuleModel>> placeShowcaseModules(
  Ref ref,
  String placeId,
) async {
  if (placeId.isEmpty) return const [];

  final result = await ProjectDependencyItems.firestoreService
      .getSingleData<MerchantShowcaseModel>(
        model: const MerchantShowcaseModel(),
        path: CollectionPaths.approvedApplications,
        id: placeId,
      );

  return switch (result) {
    FirebaseSuccess(:final data) =>
      data?.modules.where((module) => module.isPublished).toList() ?? const [],
    FirebaseFailure(:final error, :final message) =>
      throw PlaceShowcaseException(error, message),
  };
}
