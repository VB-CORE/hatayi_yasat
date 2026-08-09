import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/sub_feature/special_agency/provider/special_agency_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/extension/geo_point_extension.dart';
import 'package:lifeclient/product/utility/link_actions.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/app_bar/discover_section_app_bar.dart';
import 'package:lifeclient/product/widget/button/outline_action_button.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/sheet/detail_action_row.dart';
import 'package:lifeclient/product/widget/sheet/detail_sheet.dart';

part 'widget/institution_row.dart';
part 'widget/special_agency_app_bar.dart';
part 'widget/special_agency_list.dart';
part 'widget/special_agency_detail_sheet/special_agency_detail_sheet.dart';

@immutable
final class SpecialAgencyView extends ConsumerStatefulWidget {
  const SpecialAgencyView({super.key});

  @override
  ConsumerState<SpecialAgencyView> createState() => _SpecialAgencyViewState();
}

final class _SpecialAgencyViewState extends ConsumerState<SpecialAgencyView>
    with AppProviderMixin<SpecialAgencyView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_fetchAgencies());
    });
  }

  Future<void> _fetchAgencies() async {
    await ref
        .read(specialAgencyViewModelProvider.notifier)
        .fetchAgencyCollectionReference(productProvider.regionalTowns);
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      appBar: const _SpecialAgencyAppBar(),
      body: const _SpecialAgencyList(),
    );
  }
}
