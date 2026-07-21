import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_shadows.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/features/community/rate/view/rate_comment_list_view.dart';
import 'package:lifeclient/features/place_detail/mixin/place_detail_view_mixin.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/utility/constants/app_icon_sizes.dart';
import 'package:lifeclient/product/utility/constants/index.dart';
import 'package:lifeclient/product/utility/extension/store_etension.dart';
import 'package:lifeclient/product/utility/mixin/app_provider_mixin.dart';
import 'package:lifeclient/product/utility/mock/place_meta_mock.dart';
import 'package:lifeclient/product/widget/background/mosaic_background.dart';
import 'package:lifeclient/product/widget/bounceable/bounceable.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/product/widget/image/custom_image_with_view_dialog.dart';
import 'package:lifeclient/product/widget/pill/status_pill.dart';
import 'package:lifeclient/product/widget/rating/place_rating_label.dart';
import 'package:lifeclient/product/widget/shimmer/shimmer.dart';

part 'widget/place_address_card.dart';
part 'widget/place_detail_header.dart';
part 'widget/place_detail_tab_bar.dart';
part 'widget/place_detail_tab_content.dart';
part 'widget/place_summary_card.dart';
part 'widget/tabs/place_detail_about.dart';
part 'widget/tabs/place_detail_comments.dart';

enum _PlaceDetailTab { about, comments }

final class PlaceDetailView extends ConsumerStatefulWidget {
  const PlaceDetailView({
    required this.store,
    required this.id,
    super.key,
  });

  final StoreModel store;
  final String id;

  @override
  ConsumerState<PlaceDetailView> createState() => _PlaceDetailViewState();
}

final class _PlaceDetailViewState extends ConsumerState<PlaceDetailView>
    with PlaceDetailViewMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _PlaceDetailTab.values.length,
      child: Scaffold(
        backgroundColor: AppColors.bg,
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            PlaceDetailHeader(
              store: widget.store,
              scrollController: scrollController,
              patternHeight: context.sized.dynamicHeight(patternHeightFactor),
              onCall: onCall,
              onComment: onComment,
            ),
            const PinnedHeaderSliver(
              child: PlaceDetailTabBar(),
            ),
            SliverPadding(
              padding: const PagePadding.generalAllLow(),
              sliver: SliverToBoxAdapter(
                child: PlaceDetailTabContent(
                  store: widget.store,
                  onCall: onCall,
                  onCopyAddress: onCopyAddress,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
