import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:vbaseproject/core/dependency/project_dependency_items.dart';
import 'package:vbaseproject/features/settings_module/special_agency/special_agency_view.dart';

mixin SpecialAgencyViewMixin on ConsumerState<SpecialAgencyView> {
  late final List<SpecialAgencyModel> _agencyItems;

  List<SpecialAgencyModel> get agencyItems => _agencyItems;

  @override
  void initState() {
    super.initState();
    _agencyItems =
        ref.read(ProjectDependencyItems.productProviderState).agencyItems;
  }

  Future<void> onRefresh() async {}
}
