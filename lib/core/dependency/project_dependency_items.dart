import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/service/auth/auth_service.dart';
import 'package:lifeclient/core/service/user/user_service.dart';
import 'package:lifeclient/product/feature/cache/product_cache.dart';
import 'package:lifeclient/product/init/firebase_custom_service.dart';
import 'package:lifeclient/product/utility/state/app_provider.dart';
import 'package:lifeclient/product/utility/state/items/app_provider_state.dart';
import 'package:lifeclient/product/utility/state/items/product_provider_state.dart';
import 'package:lifeclient/product/utility/state/product_provider.dart';

@immutable
final class ProjectDependencyItems {
  const ProjectDependencyItems._();

  @Deprecated(
    'Use firestoreService, it returns FirestoreResult so timeout, permission '
    'and parse errors are no longer swallowed',
  )
  static final FirebaseCustomService firebaseService = GetIt.I
      .get<FirebaseCustomService>();

  static final CustomFirestoreService firestoreService = GetIt.I
      .get<CustomFirestoreService>();

  static final CustomStorageService storageService = GetIt.I
      .get<CustomStorageService>();

  static final AppProvider appProvider = GetIt.I.get<AppProvider>();
  static final NotifierProvider<AppProvider, AppProviderState>
  appProviderState = GetIt.I
      .get<NotifierProvider<AppProvider, AppProviderState>>();

  static final NotifierProvider<ProductProvider, ProductProviderState>
  productProviderState = GetIt.I
      .get<NotifierProvider<ProductProvider, ProductProviderState>>();

  static final ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  static final ProductCache productCache = GetIt.I.get<ProductCache>();

  static final AuthService authService = GetIt.I.get<AuthService>();
  static final UserService userService = GetIt.I.get<UserService>();
}
