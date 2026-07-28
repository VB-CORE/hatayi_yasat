import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/merchant_panel/model/merchant_showcase_module_model.dart';

final class MerchantShowcaseModel
    extends BaseFirebaseModel<MerchantShowcaseModel>
    with EquatableMixin {
  const MerchantShowcaseModel({this.modules = const [], this.documentId = ''});

  static const String fieldName = 'showcaseModules';

  final List<MerchantShowcaseModuleModel> modules;

  @override
  final String documentId;

  @override
  Map<String, dynamic> toJson() => {
    fieldName: modules.map((module) => module.toJson()).toList(),
  };

  @override
  MerchantShowcaseModel fromJson(Map<String, dynamic> json) {
    final raw = json[fieldName];
    if (raw is! List) return const MerchantShowcaseModel();
    final modules = raw
        .whereType<Map<String, dynamic>>()
        .map(MerchantShowcaseModuleModel.fromJson)
        .toList();
    return MerchantShowcaseModel(modules: modules);
  }

  @override
  MerchantShowcaseModel fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> json,
  ) {
    final data = json.data();
    if (data == null) return const MerchantShowcaseModel();
    return fromJson(data).copyWith(documentId: json.id);
  }

  MerchantShowcaseModel copyWith({
    List<MerchantShowcaseModuleModel>? modules,
    String? documentId,
  }) => MerchantShowcaseModel(
    modules: modules ?? this.modules,
    documentId: documentId ?? this.documentId,
  );

  @override
  List<Object?> get props => [modules, documentId];
}
