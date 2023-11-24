import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/v2/home/view/mixin/home_view_mixin.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/decorations/custom_radius.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/appbar/custom_app_bar.dart';
import 'package:vbaseproject/product/widget/card/general_place_card.dart';
import 'package:vbaseproject/product/widget/general/general_scaffold.dart';
import 'package:vbaseproject/product/widget/general/general_sub_title.dart';
import 'package:vbaseproject/product/widget/text/clickable_title_text.dart';
import 'package:vbaseproject/product/widget/text_field/custom_search_field.dart';

part 'widget/home_categories_area.dart';
part 'widget/home_place_area.dart';
part 'widget/home_search_field.dart';

final class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> with HomeViewMixin {
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      appBar: CustomAppBar(context: context),
      body: Padding(
        padding: const PagePadding.horizontalLowSymmetric() +
            const PagePadding.onlyTopLow(),
        child: CustomScrollView(
          controller: customScrollController,
          slivers: [
            _HomeSearchField(onChanged: () {}),
            ClickableSubTitleText(
              title: LocaleKeys.home_categories.tr(),
              onTap: () {},
            ).ext.sliver,
            const _HomeCategoryCards().ext.sliver,
            SliverPadding(
              padding: const PagePadding.vertical8Symmetric(),
              sliver: GeneralSubTitle(
                value: LocaleKeys.home_places.tr(),
                isBold: true,
              ).ext.sliver,
            ),
            const _HomePlacesArea(),
          ],
        ),
      ),
    );
  }
}
