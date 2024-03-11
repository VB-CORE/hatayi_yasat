import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/cache_manager.dart';

final class StoreModelCache with CacheModel, EquatableMixin {
  StoreModelCache({required this.storeModel});

  StoreModelCache.empty() : storeModel = StoreModel.empty();

  final StoreModel storeModel;
  @override
  StoreModelCache fromDynamicJson(dynamic json) {
    if (json is! Map<String, dynamic>) throw Exception('Invalid json type');
    final id = json['id'];
    if (id is! String) throw Exception('Invalid id type');
    return StoreModelCache(
      storeModel: storeModel.fromJson(json).copyWith(
            documentId: id,
          ),
    );
  }

  Map<String, dynamic> toJson() {
    final json = storeModel.toJson()
      ..remove('createdAt')
      ..remove('updatedAt');
    json['id'] = storeModel.documentId;
    return json;
  }

  @override
  String get id => storeModel.documentId;

  @override
  List<Object> get props => [id, storeModel];
}
