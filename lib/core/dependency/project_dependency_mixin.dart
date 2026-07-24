import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/core/service/auth/auth_service.dart';
import 'package:lifeclient/core/service/user/user_service.dart';
import 'package:lifeclient/product/feature/cache/product_cache.dart';
import 'package:lifeclient/product/init/firebase_custom_service.dart';
import 'package:lifeclient/product/utility/state/app_provider.dart';
import 'package:lifeclient/product/utility/state/items/app_provider_state.dart';
import 'package:lifeclient/product/utility/state/items/product_provider_state.dart';
import 'package:lifeclient/product/utility/state/product_provider.dart';
import 'package:riverpod/src/providers/notifier.dart';

mixin ProjectDependencyMixin {
  @Deprecated(
    'Use firestoreService, it returns FirestoreResult so timeout, permission '
    'and parse errors are no longer swallowed',
  )
  final FirebaseCustomService firebaseService =
      ProjectDependencyItems.firebaseService;

  final CustomFirestoreService firestoreService =
      ProjectDependencyItems.firestoreService;

  final CustomStorageService storageService =
      ProjectDependencyItems.storageService;

  final AppProvider appProvider = ProjectDependencyItems.appProvider;

  final NotifierProvider<AppProvider, AppProviderState> appProviderState =
      ProjectDependencyItems.appProviderState;
  final NotifierProvider<ProductProvider, ProductProviderState>
  productProviderState = ProjectDependencyItems.productProviderState;

  final ProductProvider productProvider =
      ProjectDependencyItems.productProvider;

  final ProductCache productCache = ProjectDependencyItems.productCache;

  final AuthService authService = ProjectDependencyItems.authService;

  final UserService userService = ProjectDependencyItems.userService;
}
