import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:vbaseproject/product/init/language/locale_keys.g.dart';
import 'package:vbaseproject/product/utility/constants/app_icons.dart';
import 'package:vbaseproject/product/utility/padding/page_padding.dart';
import 'package:vbaseproject/product/widget/appbar/page_app_bar.dart';
import 'package:vbaseproject/product/widget/general/index.dart';
import 'package:vbaseproject/product/widget/listtile/author_listtile_widget.dart';
import 'package:vbaseproject/product/widget/text_field/custom_search_field.dart';

part 'widget/favorite_clear_all_button.dart';
part 'widget/favorite_list_builder.dart';
part 'widget/favorite_search_field.dart';

final class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      appBar: PageAppBar(
        pageTitle: LocaleKeys.favorite_title,
        actions: [
          _FavoriteClearAllButton(
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          _FavoriteSearchField(onChanged: () {}),
          const _FavoriteListBuilder(),
        ],
      ),
    );
  }
}
