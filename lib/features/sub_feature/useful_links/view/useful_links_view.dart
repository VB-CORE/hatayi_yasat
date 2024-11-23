import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/sub_feature/useful_links/provider/useful_links_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_constants.dart';
import 'package:lifeclient/product/utility/decorations/index.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/tap_area/tap_area.dart';

part 'widget/useful_link_card.dart';
part 'widget/useful_links_list_builder.dart';

final class UsefulLinksView extends ConsumerStatefulWidget {
  const UsefulLinksView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UsefulLinksViewState();
}

class _UsefulLinksViewState extends ConsumerState<UsefulLinksView> {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      appBar: PageAppBar(
        pageTitle: LocaleKeys.usefulLink_title,
      ),
      body: const _UsefulLinksListBuilder(),
    );
  }
}
