import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/feature/cache/cache_manager.dart';

/// Memory model cache implementation for favorite memories
final class MemoryCacheModel with CacheModel, EquatableMixin {
  const MemoryCacheModel({required this.memoryModel});

  const MemoryCacheModel.empty() : memoryModel = const MemoryModel();

  final MemoryModel memoryModel;

  @override
  MemoryCacheModel fromDynamicJson(dynamic json) {
    if (json is! Map<String, dynamic>) throw Exception('Invalid json type');
    final id = json['id'];
    if (id is! String) throw Exception('Invalid id type');
    return MemoryCacheModel(
      memoryModel: MemoryModel.fromJson(json).copyWith(
        documentId: id,
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = memoryModel.toJson()
      ..remove('createdAt')
      ..remove('updatedAt');
    json['id'] = memoryModel.documentId;
    return json;
  }

  @override
  String get id => memoryModel.documentId;

  @override
  List<Object> get props => [id, memoryModel];
}
