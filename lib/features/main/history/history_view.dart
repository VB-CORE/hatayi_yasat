import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/dependency/project_dependency_mixin.dart';
import 'package:lifeclient/features/main/history/history_view_mixin.dart';
import 'package:lifeclient/features/main/history/provider/history_view_model.dart';
import 'package:lifeclient/features/main/history/widget/history_favorite_view.dart';
import 'package:lifeclient/features/main/history/widget/history_photo_detail_sheet.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/model/enum/hero_tags.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/app_icons.dart';
import 'package:lifeclient/product/utility/decorations/custom_radius.dart';
import 'package:lifeclient/product/widget/builder/firestore_grid_view.dart';
import 'package:lifeclient/product/widget/general/general_not_found_widget.dart';
import 'package:lifeclient/product/widget/general/index.dart';

part 'widget/history_grid_builder.dart';

final class HistoryView extends ConsumerStatefulWidget {
  const HistoryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryViewState();
}

class _HistoryViewState extends ConsumerState<HistoryView>
    with ProjectDependencyMixin, HistoryViewMixin {
  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      body: const _HistoryGridBuilder(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: AppIconSizes.xLarge * 2.5,
        ),
        child: Column(
          spacing: AppIconSizes.smallX,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: HeroTags.memoryFavorite.name,
              onPressed: () {
                context.route.navigateToPage(const HistoryFavoriteSheet());
              },
              child: const Icon(AppIcons.favorite),
            ),
            FloatingActionButton(
              onPressed: openGoogleForm,
              child: const Icon(Icons.add_a_photo_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
