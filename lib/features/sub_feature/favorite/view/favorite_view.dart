import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_items.dart';
import 'package:lifeclient/core/theme/app_context_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/features/sub_feature/favorite/provider/displayed_favorite_places_provider.dart';
import 'package:lifeclient/features/sub_feature/favorite/provider/favorite_view_model.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/navigation/app_router.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/utility/mixin/keyboard_utility_mixin.dart';
import 'package:lifeclient/product/widget/card/general_place_card.dart';
import 'package:lifeclient/product/widget/card/place/general_place_grid_card.dart';
import 'package:lifeclient/product/widget/dialog/general_text_dialog.dart';
import 'package:lifeclient/product/widget/dialog/sub_widget/general_dialog_button.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/text_field/custom_search_field.dart';

part 'widget/favorite_clear_all_button.dart';
part 'widget/favorite_empty_view.dart';
part 'widget/favorite_list_builder.dart';
part 'widget/favorite_search_field.dart';
part 'widget/favorite_view_toggle_button.dart';

final class FavoriteView extends ConsumerStatefulWidget {
  const FavoriteView({super.key});

  @override
  ConsumerState<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends ConsumerState<FavoriteView>
    with AppProviderMixin<FavoriteView> {
  @override
  Future<void> dispose() async {
    super.dispose();
    await KeyboardUtilityMixin.closeFromSystem();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.favorite_title.tr(context: context)),
        actions: const [
          _FavoriteViewToggleButton(),
          SizedBox(width: AppSpacing.md),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          _FavoriteSearchField(
            onChanged: (value) {
              ref
                  .read(favoriteViewModelProvider.notifier)
                  .searchFavorites(value);
            },
          ),
          SliverToBoxAdapter(
            child: Consumer(
              builder: (context, ref, child) {
                final isFavoritePlacesEmpty =
                    productStateWatch.favoritePlaces.isEmpty;
                if (isFavoritePlacesEmpty) return const SizedBox.shrink();
                return _FavoriteClearAllButton(
                  onPressed: (value) async {
                    if (!value) return;
                    await productProvider.removeAllFavoritePlaces();
                  },
                );
              },
            ),
          ),
          const _FavoriteListBuilder(),
        ],
      ),
    );
  }
}
