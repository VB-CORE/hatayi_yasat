import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/settings_module/developers/developers_view.dart';

mixin DeveloperViewMixin on ConsumerState<DevelopersView> {
  late final List<DeveloperModel> _devItems;

  List<DeveloperModel> get devItems => _devItems;

  @override
  void initState() {
    super.initState();
    _devItems = [];
  }

  Future<void> onRefresh() async {
    // await ref
    //     .read(ProductProvider.provider.notifier)
    //     .fetchDevelopersAndAgency();
    // _devItems = appState.developerItems;
  }
}
