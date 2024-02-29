import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/developers/provider/developers_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/builder/firestore_grid_view.dart';
import 'package:lifeclient/product/widget/card/developer_profile_card.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';

part 'widget/developers_grid_builder.dart';

final class DevelopersView extends ConsumerStatefulWidget {
  const DevelopersView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DevelopersViewState();
}

class _DevelopersViewState extends ConsumerState<DevelopersView> {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      appBar: PageAppBar(
        pageTitle: LocaleKeys.developers_title,
      ),
      body: const _DevelopersGridBuilder(),
    );
  }
}
