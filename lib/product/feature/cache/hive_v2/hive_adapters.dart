import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_ce/hive.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/app_cache_model.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/memory_cache_model.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/store_model_cache.dart';

@GenerateAdapters([
  AdapterSpec<AppCacheModel>(),
  AdapterSpec<StoreModelCache>(),
  AdapterSpec<MemoryCacheModel>(),
  AdapterSpec<StoreModel>(),
  AdapterSpec<MemoryModel>(),
  AdapterSpec<GeoPoint>(),
  AdapterSpec<CategoryModel>(),
])
part 'hive_adapters.g.dart';
