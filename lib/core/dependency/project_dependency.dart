import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/hive_cache.dart';
import 'package:lifeclient/product/feature/cache/product_cache.dart';
import 'package:lifeclient/product/init/firebase_custom_service.dart';
import 'package:lifeclient/product/utility/state/app_provider.dart';
import 'package:lifeclient/product/utility/state/items/app_provider_state.dart';
import 'package:lifeclient/product/utility/state/items/product_provider_state.dart';
import 'package:lifeclient/product/utility/state/product_provider.dart';

@immutable
final class ProjectDependency {
  ProjectDependency.setup() {
    final appProvider = AppProvider();
    final productProvider = ProductProvider();
    GetIt.I.registerSingleton<AppProvider>(appProvider);
    GetIt.I.registerSingleton<ProductProvider>(productProvider);

    GetIt.I.registerSingleton<ProductCache>(
      ProductCache(cacheManager: HiveCacheManager()),
    );

    GetIt.I.registerFactory(FirebaseCustomService.new);

    GetIt.I.registerSingleton<
        NotifierProvider<AppProvider, AppProviderState>>(
      NotifierProvider<AppProvider, AppProviderState>(
        () => ProjectDependencyItems.appProvider,
      ),
    );

    GetIt.I.registerSingleton<
        NotifierProvider<ProductProvider, ProductProviderState>>(
      NotifierProvider<ProductProvider, ProductProviderState>(
        () => ProjectDependencyItems.productProvider,
      ),
    );
  }
}
