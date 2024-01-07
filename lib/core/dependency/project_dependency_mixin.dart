import 'package:vbaseproject/core/dependency/project_dependency_items.dart';
import 'package:vbaseproject/product/feature/cache/hive_v2/product_cache.dart';
import 'package:vbaseproject/product/init/firebase_custom_service.dart';
import 'package:vbaseproject/product/utility/state/app_provider.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';

mixin ProjectDependencyMixin {
  final FirebaseCustomService firebaseService =
      ProjectDependencyItems.firebaseService;

  final AppProvider appProvider = ProjectDependencyItems.appProvider;

  final appProviderState = ProjectDependencyItems.appProviderState;
  final productProviderState = ProjectDependencyItems.productProviderState;

  final ProductProvider productProvider =
      ProjectDependencyItems.productProvider;

  final ProductCache productCache = ProjectDependencyItems.productCache;
}
