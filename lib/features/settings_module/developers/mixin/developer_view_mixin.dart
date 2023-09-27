import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/settings_module/developers/developers_view.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';

mixin DeveloperViewMixin on ConsumerState<DevelopersView> {
  ProductProviderState get appState => ref.read(ProductProvider.provider);
  late final List<DeveloperModel> _devItems;

  List<DeveloperModel> get devItems => _devItems;

  @override
  void initState() {
    super.initState();
    _devItems = appState.developerItems;
  }

  Future<void> onRefresh() async {
    await ref
        .read(ProductProvider.provider.notifier)
        .fetchDevelopersAndAgency();
    _devItems = appState.developerItems;
  }
}
