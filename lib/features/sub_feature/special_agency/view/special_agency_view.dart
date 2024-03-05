import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/special_agency/provider/special_agency_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/mixin/redirection_mixin.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';

part 'widget/special_agency_card.dart';
part 'widget/special_agency_list_builder.dart';

final class SpecialAgencyView extends ConsumerStatefulWidget {
  const SpecialAgencyView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SpecialAgencyViewState();
}

class _SpecialAgencyViewState extends ConsumerState<SpecialAgencyView> {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      appBar: PageAppBar(
        pageTitle: LocaleKeys.specialAgency_title,
      ),
      body: const _SpecialAgencyListBuilder(),
    );
  }
}
