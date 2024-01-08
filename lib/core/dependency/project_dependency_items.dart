import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:vbaseproject/product/feature/cache/hive_v2/product_cache.dart';
import 'package:vbaseproject/product/init/firebase_custom_service.dart';
import 'package:vbaseproject/product/utility/state/app_provider.dart';
import 'package:vbaseproject/product/utility/state/items/app_provider_state.dart';
import 'package:vbaseproject/product/utility/state/items/product_provider_state.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';

@immutable
final class ProjectDependencyItems {
  const ProjectDependencyItems._();

  static final FirebaseCustomService firebaseService =
      GetIt.I.get<FirebaseCustomService>();

  static final AppProvider appProvider = GetIt.I.get<AppProvider>();
  static final appProviderState =
      GetIt.I.get<StateNotifierProvider<AppProvider, AppProviderState>>();

  static final productProviderState = GetIt.I
      .get<StateNotifierProvider<ProductProvider, ProductProviderState>>();

  static final ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  static final ProductCache productCache = GetIt.I.get<ProductCache>();
}
