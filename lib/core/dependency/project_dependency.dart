import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/hive_cache.dart';
import 'package:lifeclient/product/feature/cache/product_cache.dart';
import 'package:lifeclient/product/feature/cache/shared_v2/shared_cache_manager.dart';
import 'package:lifeclient/product/init/firebase_custom_service.dart';
import 'package:lifeclient/product/utility/state/app_provider.dart';
import 'package:lifeclient/product/utility/state/items/app_provider_state.dart';
import 'package:lifeclient/product/utility/state/items/product_provider_state.dart';
import 'package:lifeclient/product/utility/state/product_provider.dart';

@immutable
final class ProjectDependency {
  ProjectDependency.setup() {
    GetIt.I.registerSingleton<AppProvider>(AppProvider());
    GetIt.I.registerSingleton<ProductProvider>(ProductProvider());

    GetIt.I.registerSingleton<ProductCache>(
      ProductCache(cacheManager: SharedCacheManager()),
    );

    GetIt.I.registerFactory(FirebaseCustomService.new);

    GetIt.I.registerSingleton<
        StateNotifierProvider<AppProvider, AppProviderState>>(
      StateNotifierProvider<AppProvider, AppProviderState>(
        (ref) => ProjectDependencyItems.appProvider,
      ),
    );

    GetIt.I.registerSingleton<
        StateNotifierProvider<ProductProvider, ProductProviderState>>(
      StateNotifierProvider<ProductProvider, ProductProviderState>(
        (ref) => ProjectDependencyItems.productProvider,
      ),
    );
  }
}
