import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/settings_module/special_agency/special_agency_view.dart';
import 'package:vbaseproject/product/model/firebase/special_agency_model.dart';

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
}
