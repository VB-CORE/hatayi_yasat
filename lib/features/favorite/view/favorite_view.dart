import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/features/favorite/provider/favorite_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/widget/app_bar/page_app_bar.dart';
import 'package:lifeclient/product/widget/dialog/general_text_dialog.dart';
import 'package:lifeclient/product/widget/dialog/sub_widget/general_dialog_button.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/list_tile/author_listtile_widget.dart';
import 'package:lifeclient/product/widget/text_field/custom_search_field.dart';

part 'widget/favorite_clear_all_button.dart';
part 'widget/favorite_list_builder.dart';
part 'widget/favorite_search_field.dart';

final class FavoriteView extends ConsumerStatefulWidget {
  const FavoriteView({super.key});

  @override
  ConsumerState<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends ConsumerState<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      appBar: PageAppBar(
        pageTitle: LocaleKeys.favorite_title,
        actions: [
          if (ref.watch(favoriteViewModelProvider).favoritePlaces.isNotEmpty)
            _FavoriteClearAllButton(
              onPressed: (value) {
                if (!value) return;
                ref
                    .read(favoriteViewModelProvider.notifier)
                    .removeAllFavoritePlaces();
              },
            ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          _FavoriteSearchField(
            onChanged: (String value) {
              ref
                  .read(favoriteViewModelProvider.notifier)
                  .searchFavorites(value);
            },
          ),
          const _FavoriteListBuilder(),
        ],
      ),
    );
  }
}
