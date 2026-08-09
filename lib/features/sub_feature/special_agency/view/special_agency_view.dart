import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/sub_feature/special_agency/provider/special_agency_state.dart';
import 'package:lifeclient/features/sub_feature/special_agency/provider/special_agency_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/utility/link_actions.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/widget/app_bar/discover_section_app_bar.dart';
import 'package:lifeclient/product/widget/button/outline_action_button.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/sheet/detail_action_row.dart';
import 'package:lifeclient/product/widget/sheet/detail_sheet.dart';

part 'widget/institution_row.dart';
part 'widget/special_agency_detail_sheet/special_agency_detail_sheet.dart';

@immutable
final class SpecialAgencyView extends ConsumerWidget {
  const SpecialAgencyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(
      specialAgencyViewModelProvider.select(
        (state) => state.townNamesAndAgency,
      ),
    );
    final institutionCount = groups.values.fold<int>(
      0,
      (total, agencies) => total + agencies.length,
    );

    return GeneralScaffold(
      appBar: DiscoverSectionAppBar(
        title: LocaleKeys.specialAgency_title,
        subtitle: LocaleKeys.specialAgency_subtitle.tr(
          args: [institutionCount.toString(), groups.length.toString()],
        ),
        accentColor: context.appColors.navy,
      ),
      body: const _SpecialAgencyListBuilder(),
    );
  }
}

final class _SpecialAgencyListBuilder extends ConsumerStatefulWidget {
  const _SpecialAgencyListBuilder();

  @override
  ConsumerState<_SpecialAgencyListBuilder> createState() =>
      __SpecialAgencyListBuilderState();
}

final class __SpecialAgencyListBuilderState
    extends ConsumerState<_SpecialAgencyListBuilder>
    with AppProviderMixin, _SpecialAgencyListBuilderMixin {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding:
          const PagePadding.horizontal16Symmetric() +
          const PagePadding.vertical8Symmetric(),
      itemCount: townNamesAndAgency.length,
      itemBuilder: (context, index) {
        final townName = townNamesAndAgency.keys.elementAt(index);
        final agencyList = townNamesAndAgency[townName];

        if (agencyList == null) {
          return const EmptyBox.smallHeight();
        }

        return GeneralExpansionTile(
          title: townName,
          subtitle: LocaleKeys.specialAgency_groupCount.tr(
            args: [agencyList.length.toString()],
          ),
          leadingIcon: AppIcons.city,
          initiallyExpanded: index == 0,
          children: agencyList
              .map(
                (agency) =>
                    _InstitutionRow(institution: agency, district: townName),
              )
              .toList(),
        );
      },
    );
  }
}

mixin _SpecialAgencyListBuilderMixin
    on
        ConsumerState<_SpecialAgencyListBuilder>,
        AppProviderMixin<_SpecialAgencyListBuilder> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _init();
    });
  }

  Future<void> _init() async {
    final towns = productProvider.regionalTowns;
    await ref
        .read(specialAgencyViewModelProvider.notifier)
        .fetchAgencyCollectionReference(towns);
  }

  SpecialAgencyState get _state => ref.watch(specialAgencyViewModelProvider);
  Map<String, List<SpecialAgencyModel>> get townNamesAndAgency =>
      _state.townNamesAndAgency;
}
