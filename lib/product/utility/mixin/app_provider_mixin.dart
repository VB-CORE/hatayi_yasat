import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/core/dependency/project_dependency_items.dart';
import 'package:vbaseproject/product/utility/state/app_provider.dart';
import 'package:vbaseproject/product/utility/state/items/app_provider_state.dart';
import 'package:vbaseproject/product/utility/state/items/product_provider_state.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';

mixin AppProviderMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  AppProvider get appProvider =>
      ref.read(ProjectDependencyItems.appProviderState.notifier);
  AppProviderState get appState =>
      ref.read(ProjectDependencyItems.appProviderState);

  ProductProvider get productProvider =>
      ref.read(ProjectDependencyItems.productProviderState.notifier);

  ProductProviderState get productState =>
      ref.read(ProjectDependencyItems.productProviderState);

  ProductProviderState get productStateWatch =>
      ref.watch(ProjectDependencyItems.productProviderState);
}

mixin AppProviderStateMixin on ConsumerWidget {
  /// General app requries
  AppProvider appProvider(WidgetRef ref) =>
      ref.read(ProjectDependencyItems.appProviderState.notifier);
  AppProviderState appState(WidgetRef ref) =>
      ref.read(ProjectDependencyItems.appProviderState);
  AppProviderState appStateWatch(WidgetRef ref) =>
      ref.watch(ProjectDependencyItems.appProviderState);

  /// General product requries
  ProductProvider productProvider(WidgetRef ref) =>
      ref.read(ProjectDependencyItems.productProviderState.notifier);
  ProductProviderState productState(WidgetRef ref) =>
      ref.read(ProjectDependencyItems.productProviderState);
}
