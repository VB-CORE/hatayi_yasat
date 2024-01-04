import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/features/v2/home/provider/home_view_model.dart';
import 'package:vbaseproject/features/v2/home/view/mixin/home_view_mixin.dart';
import 'package:vbaseproject/features/v2/sub_feature/filter_and_search/model/filter_selected.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/model/enum/text_field/text_field_max_lenghts.dart';
import 'package:vbaseproject/product/navigation/app_router.dart';
import 'package:vbaseproject/product/utility/decorations/custom_radius.dart';
import 'package:vbaseproject/product/utility/decorations/empty_box.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/general/general_place_card.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/general/list/general_firestore_list_sliver_view.dart';
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
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const ClampingScrollPhysics(),
        slivers: [
          _HomeSearchField(onChanged: () {}),
          ClickableSubTitleText(
            title: LocaleKeys.home_categories.tr(),
            onTap: () async {
              final result =
                  await const FilterRoute().push<FilterSelected?>(context);
              if (result == null) return;
            },
          ).ext.sliver,
          const SliverPadding(
            padding: PagePadding.vertical6Symmetric(),
            sliver: _HomeCategoryCards(),
          ),
          SliverPadding(
            padding: const PagePadding.onlyBottom(),
            sliver: GeneralSubTitle(
              value: LocaleKeys.home_places.tr(),
              fontWeight: FontWeight.bold,
            ).ext.sliver,
          ),
          const _HomePlacesArea(),
          const EmptyBox.largeXHeight().ext.sliver,
        ],
      ),
    );
  }
}


  // FloatingActionButton(
  //           onPressed: () async {
  //             final callable = FirebaseFunctions.instance.httpsCallable(
  //               'search',
  //               options: HttpsCallableOptions(
  //                 timeout: const Duration(seconds: 5),
  //               ),
  //             );

  //             // Fonksiyonu parametreler ile çağırın (eğer varsa)
  //             final results = await callable.call(<String, dynamic>{
  //               'term': 'rumo',
  //               'page': '1',
  //             });

  //             print(results);
  //           },
  //         ).ext.sliver,