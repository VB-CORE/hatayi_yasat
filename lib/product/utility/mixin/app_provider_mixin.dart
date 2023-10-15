import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/product/utility/state/app_provider.dart';
import 'package:vbaseproject/product/utility/state/items/app_provider_state.dart';

mixin AppProviderMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  AppProvider get appProvider => ref.read(AppProvider.provider.notifier);
  AppProviderState get appState => ref.read(AppProvider.provider);
}

mixin AppProviderStateMixin<T> on ConsumerWidget {
  AppProvider appProvider(WidgetRef ref) =>
      ref.read(AppProvider.provider.notifier);
  AppProviderState appState(WidgetRef ref) => ref.read(AppProvider.provider);
  AppProviderState appStateWatch(WidgetRef ref) =>
      ref.watch(AppProvider.provider);
}
