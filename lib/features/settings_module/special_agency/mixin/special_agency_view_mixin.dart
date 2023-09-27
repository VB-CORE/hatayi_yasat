import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/features/settings_module/special_agency/special_agency_view.dart';
import 'package:vbaseproject/product/utility/state/product_provider.dart';

mixin SpecialAgencyViewMixin on ConsumerState<SpecialAgencyView> {
  ProductProviderState get appState => ref.read(ProductProvider.provider);
  late final List<SpecialAgencyModel> _agencyItems;

  List<SpecialAgencyModel> get agencyItems => _agencyItems;

  @override
  void initState() {
    super.initState();
    _agencyItems = appState.agencyItems;
  }

  Future<void> onRefresh() async {
    await ref
        .read(ProductProvider.provider.notifier)
        .fetchDevelopersAndAgency();
    _agencyItems = appState.agencyItems;
  }
}
