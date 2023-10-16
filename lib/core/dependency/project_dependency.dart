import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:vbaseproject/product/utility/state/app_provider.dart';
import 'package:vbaseproject/product/utility/state/items/app_provider_state.dart';

@immutable
final class ProjectDependency {
  ProjectDependency.setup() {
    GetIt.I.registerSingleton<AppProvider>(AppProvider());
    GetIt.I.registerSingleton<
        StateNotifierProvider<AppProvider, AppProviderState>>(
      StateNotifierProvider<AppProvider, AppProviderState>(
        (ref) => ProjectDependencyItems.appProvider,
      ),
    );
  }
}

final class ProjectDependencyItems {
  const ProjectDependencyItems._();
  static final AppProvider appProvider = GetIt.I.get<AppProvider>();
  static final StateNotifierProvider<AppProvider, AppProviderState>
      appProviderState =
      GetIt.I.get<StateNotifierProvider<AppProvider, AppProviderState>>();
}
